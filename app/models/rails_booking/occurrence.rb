module RailsBooking::Occurrence
  
  
  
  
  def next_occurrence(now: Time.current)
    ti = time_items.find { |i| i.start_at.to_s(:time) > now.to_s(:time) }
    if ti
      date = next_occurred_days(limit: 1).first
      hour, min = ti.start_at.to_s(:time).split(':')
      date.to_datetime.change(hour: hour.to_i, min: min.to_i)
    else
      date = next_occurred_days(limit: 2).last
      t2 = time_items.first
      hour, min = t2.start_at.to_s(:time).split(':')
      date.to_datetime.change(hour: hour.to_i, min: min.to_i)
    end
  end
  
  def next_occurred_days(now: Time.current, limit: 1)
    days = self.repeat_days.keys
    r = []
    case self.repeat_type
    when 'weekly'
      first_days = days.select { |day| day.to_i >= now.days_to_week_start }
      first_days.each do |day|
        r << now.beginning_of_week.days_since(day.to_i)
        limit -= 1
        return r if limit.zero?
      end
      (1..).each do |week|
        days.each do |day|
          r << now.weeks_since(week).beginning_of_week.days_since(day.to_i)
          limit -= 1
          return r if limit.zero?
        end
      end
    when 'monthly'
      first_days = days.select { |day| day.to_i >= now.day }
      first_days.each do |day|
        r << now.beginning_of_month.days_since(day.to_i)
        limit -= 1
        return r if limit.zero?
      end
      (1..).each do |month|
        days.each do |day|
          r << now.weeks_since(month).beginning_of_month.days_since(day.to_i)
          limit -= 1
          return r if limit.zero?
        end
      end
    when 'once'
      first_days = days.select { |day| day.to_date >= now.to_date }
      first_days.each do |date|
        r << date
        limit -= 1
        return r if limit.zero?
      end
    end
    r
  end
  
  
end
