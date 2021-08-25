module Eventual
  module Ext::Recurrence
    extend ActiveSupport::Concern

    included do
      attribute :repeat_type, :string, default: ''
      attribute :repeat_days, :integer, array: true, default: []

      enum repeat_type: {
        once: 'once',
        weekly: 'weekly',
        monthly: 'monthly'
      }

      before_save :deal_repeat_days, if: -> { repeat_days_changed? }
    end

    def deal_repeat_days
      self.repeat_days = self.repeat_days.map(&:to_i)
    end


    def next_start_at
      return if start_at.nil?
      _next_day = self.next_day
      _next_day.change(hour: start_at.hour, min: start_at.min, sec: start_at.sec)
    end

    def next_finish_at
      return if finish_at.nil?
      _next_day = self.next_day
      _next_day.change(hour: finish_at.hour, min: finish_at.min, sec: finish_at.sec)
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
end
