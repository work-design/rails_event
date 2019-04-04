module TimeListCalendar

  def default_date
    Date.today
  end

  def slot_duration
    g = item_minutes.gcd(interval_minutes)
    (Time.current.beginning_of_day + g.minutes).to_s(:time)
  end

  def slot_label_interval
    g = item_minutes + interval_minutes
    (Time.current.beginning_of_day + g.minutes).to_s(:time)
  end

  def min_time
    if time_items.size > 0
      time_items[0].start_at.to_s(:time)
    else
      '08:00'
    end
  end

  def max_time
    if time_items.size > 0
      time_items[-1].finish_at.to_s(:time)
    else
      '18:00'
    end
  end

  def events(day_count)
    day_count.times.map do |count|
      item_events(count)
    end.flatten
  end

  def item_events(span = 0)
    time_items.map do |time_item|
      time_item.event(span)
    end
  end

end
