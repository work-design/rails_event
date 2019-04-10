module TimeListCalendar

  def default_date
    Date.today.beginning_of_month
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

  def item_events(span = 0, selected_ids: [])
    time_items.map do |time_item|
      if selected_ids.include?(time_item.id)
        time_item.selected_event(span)
      else
        time_item.event(span)
      end
    end
  end

end
