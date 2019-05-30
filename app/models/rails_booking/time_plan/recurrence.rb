module RailsBooking::TimePlan::Recurrence
  extend ActiveSupport::Concern

  included do
    attribute :repeat_type, :string, default: 'weekly'
    attribute :repeat_days, :json, default: {}

    enum repeat_type: {
      once: 'once',
      weekly: 'weekly',
      monthly: 'monthly'
    }
  end

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

  def next_occurring(start: Time.current, finish: start + 14.days)
    (start.to_date .. finish.to_date).map do |date|
      span = repeat_index(date)
      yield(span, date)
    end.compact
  end

  def next_days(start: Time.current, finish: start + 14.days)
    next_occurring(start: start, finish: finish) do |span, date|
      {
        date.to_s => repeat_days[span]
      } if repeat_days.key?(span)
    end.to_combine_h
  end

  def next_occurrences(start: Time.current, finish: start + 14.days, filter_options: {})
    next_occurring(start: start, finish: finish) do |span, date|
      {
        date: date.to_s,
        occurrences: time_items.map do |i|
          {
            id: i.id,
            date: date.to_s,
            start_at: i.start_at.to_s(:time),
            finish_at: i.finish_at.to_s(:time),
            present_number: self.plan.present_number,
            limit_number: self.plan.limit_number,
            room: self.plan.room&.as_json(only: [:id], methods: [:name]),
            crowd: self.plan.crowd.as_json(only: [:id, :name]),
            booked: time_bookings.default_where(filter_options.merge(booking_on: date, time_item_id: i.id)).exists?
          } if Array(repeat_days[span]).include?(i.id)
        end.compact
      } if repeat_days.key?(span)
    end
  end

  def next_events(start: Time.current, finish: start + 7.days)
    next_occurring(start: start, finish: finish) do |span, date|
      time_items.map do |i|
        ext = {
          title: self.plan.title,
          room: self.plan.room.as_json(only: [:id], methods: [:name])
        }
        ext.merge! crowd: self.plan.crowd.as_json(only: [:id, :name]) if self.plan.respond_to?(:crowd)

        {
          id: i.id,
          start: i.start_at.change(date.parts).strftime('%FT%T'),
          end: i.finish_at.change(date.parts).strftime('%FT%T'),
          title: "#{plan.room.name} #{self.plan.title}",
          extendedProps: ext
        } if Array(repeat_days[span]).include?(i.id)
      end.compact if repeat_days.key?(span)
    end.flatten
  end

end
