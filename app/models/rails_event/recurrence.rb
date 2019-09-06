module RailsEvent::Recurrence
  extend ActiveSupport::Concern

  included do
    attribute :repeat_type, :string, default: 'weekly'
    attribute :repeat_count, :integer, default: 1
    attribute :repeat_days, :json, default: {}

    enum repeat_type: {
      once: 'once',
      weekly: 'weekly',
      monthly: 'monthly'
    }
  end

  def repeat_index(date)
    case repeat_type
    when 'weekly'
      date.days_to_week_start.to_s
    when 'monthly'
      (date.day - 1).to_s
    when 'once'
      date.to_s(:date)
    end
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

  def next_events(start: Time.current, finish: start + 7.days)
    next_occurring(start: start, finish: finish) do |span, date|
      time_items.map do |i|
        ext = {
          title: self.plan.title,
          place: self.plan.place.as_json(only: [:id], methods: [:name])
        }
        ext.merge! crowd: self.plan.crowd.as_json(only: [:id, :name]) if self.plan.respond_to?(:crowd)

        {
          id: i.id,
          start: i.start_at.change(date.parts).strftime('%FT%T'),
          end: i.finish_at.change(date.parts).strftime('%FT%T'),
          title: "#{plan.place.name} #{self.plan.title}",
          extendedProps: ext
        } if Array(repeat_days[span]).include?(i.id)
      end.compact if repeat_days.key?(span)
    end.flatten
  end

end
