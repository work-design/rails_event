module TimePlanRecurrence
  extend ActiveSupport::Concern

  included do
    attribute :repeat_type, :string, default: ''
    if defined?(ActiveRecord::ConnectionAdapters::PostgreSQLAdapter) && connection.is_a?(ActiveRecord::ConnectionAdapters::PostgreSQLAdapter)
      attribute :repeat_days, :json, default: {}
    else
      serialize :repeat_days, Hash
    end

    enum repeat_type: {
      once: 'once',
      weekly: 'weekly',
      monthly: 'monthly'
    }
  end

  def next_day(datetime = Time.now)
    if self.repeat_type == 'weekly'
      next_weekly_day(datetime)
    elsif self.repeat_type == 'monthly'
      next_monthly_day(datetime)
    else
      datetime
    end
  end

  def next_weekly_day(datetime = Time.now)
    start_at_date = self.start_at.change(year: datetime.year, month: datetime.month, day: datetime.day)

    if start_at_date > datetime
      next_days = self.repeat_days.select { |day| day >= datetime.days_to_week_start(:sunday) }
    else
      next_days = self.repeat_days.select { |day| day > datetime.days_to_week_start(:sunday) }
    end

    if next_days.size > 0
      next_day = next_days.min
    else
      next_day = self.repeat_days.min
    end

    str = Date::DAYS_INTO_WEEK.key(next_day)
    day = datetime.next_occurring(str)
    datetime.change(month: day.month, day: day.day)
  end

  def next_monthly_day(datetime = Time.now)
    start_at_date = self.start_at.change(year: datetime.year, month: datetime.month, day: datetime.day)

    if start_at_date > datetime
      next_days = self.repeat_days.select { |day| day >= datetime.day }
    else
      next_days = self.repeat_days.select { |day| day > datetime.day }
    end

    if next_days.size > 0
      next_day = next_days.min
      month = datetime.month
    else
      next_day = self.repeat_days.min
      month = datetime.next_month.month
    end

    datetime.change(month: month, day: next_day)
  end

end
