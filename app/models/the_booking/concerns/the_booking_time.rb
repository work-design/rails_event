module TheBookingTime
  extend ActiveSupport::Concern

  included do
    #attribute :repeat_type, :string, default: ''
    #attribute :repeat_days, :integer, array: true
    #attribute :start_at, :datetime
    #attribute :finish_at, :datetime

    unless connection.is_a? ActiveRecord::ConnectionAdapters::PostgreSQLAdapter
      serialize :repeat_days, Array
    end

    enum repeat_type: {
      once: 'once',
      week: 'week',
      month: 'month',
      year: 'year'
    }

    validate :validate_finish_at

    before_save :deal_repeat_days, if: -> { repeat_days_changed? }
  end

  def validate_finish_at
    return if finish_at.nil? && start_at.nil?
    unless finish_at > start_at
      self.errors.add :finish_at, 'Finish At Should large then Start at time!'
    end
  end

  def deal_repeat_days
    self.repeat_days = self.repeat_days.map(&:to_i)
  end

  def extra
    {}
  end

  def next_start_time
    if start_at.nil?
      return start_at
    end
    if self.once?
      self.start_at
    else
      self.next_start_at
    end
  end

  def next_finish_time
    if finish_at.nil?
      return finish_at
    end
    if self.once?
      self.finish_at
    else
      self.next_finish_at
    end
  end

  def next_start_at
    return if start_at.nil?
    _next_day = self.next_day(Time.now)
    _next_day.change(hour: start_at.hour, min: start_at.min, sec: start_at.sec)
  end

  def next_finish_at
    return if finish_at.nil?
    _next_day = self.next_day(Time.now)
    _next_day.change(hour: finish_at.hour, min: finish_at.min, sec: finish_at.sec)
  end

  def next_day(datetime)
    start_at_date = self.start_at.change(year: datetime.year, month: datetime.month, day: datetime.day)

    if start_at_date > datetime
      if self.repeat_type == 'week'
        next_days = self.repeat_days.select { |day| day >= datetime.days_to_week_start }
      else #if self.repeat_type == 'month'
        next_days = self.repeat_days.select { |day| day >= datetime.day }
      end
    else
      next_days = self.repeat_days.select { |day| day > datetime.day }
    end

    if next_days.size > 0
      if self.repeat_type == 'week'
        days_span = next_days[0] - datetime.days_to_week_start
        day = datetime.beginning_of_week.days_since(days_span)
        month = day.month
        min = day.day
      else
        month = datetime.month
        min = next_days[0]
      end

      next_day = datetime.change(month: month, day: min)
    else
      if self.repeat_type == 'week'
        str = Date::DAYS_INTO_WEEK.key(self.repeat_days.min)
        day = datetime.next_week(str)
        month = day.month
        min = day.day
      else
        month = datetime.next_month.month
        min = self.repeat_days.min
      end

      next_day = datetime.change(month: month, day: min)
    end
    next_day
  end

end
