module TimeListCalendar

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

  def events(date, day_count = 7)
    default_date = date.to_date
    (default_date .. default_date + day_count).map do |date|
      item_events(date)
    end.flatten
  end

  def item_events(date, selected_ids: [])
    time_items.map do |time_item|
      if selected_ids.include?(time_item.id)
        time_item.event(date, selected: true)
      else
        time_item.event(date)
      end
    end
  end

end
