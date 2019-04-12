module TimePlanRecurrence
  extend ActiveSupport::Concern

  included do
    attribute :repeat_type, :string, default: 'weekly'
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

  def next_occurrence(now: Time.current)
    ts = time_items.select { |i| i.start_at.to_s(:time) > now.to_s(:time) }

  end

  def next_occurrences(start: Time.current, finish: start + 14.days)

  end

  def next_occurred_days(now: Time.current)
    days = self.repeat_days.keys

    case self.repeat_type
    when 'weekly'
      r1 = days.select { |day| day >= now.days_to_week_start }
      days.min

    when 'monthly'
      (start.to_date .. finish.to_date).select { |date| days.include?(date.day) }
    when 'once'
      (start.to_date .. finish.to_date).select { |date| days.include?(date.to_s) }
    end
  end

  def next_days(start: Time.current, finish: start + 14.days)
    days = self.repeat_days.keys

    case self.repeat_type
    when 'weekly'
      (start.to_date .. finish.to_date).select { |date| days.include?(date.days_to_week_start) }
    when 'monthly'
      (start.to_date .. finish.to_date).select { |date| days.include?(date.day) }
    when 'once'
      (start.to_date .. finish.to_date).select { |date| days.include?(date.to_s) }
    end
  end


end
