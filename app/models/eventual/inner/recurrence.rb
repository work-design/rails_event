module Eventual
  module Inner::Recurrence
    extend ActiveSupport::Concern

    included do
      attribute :repeat_type, :string, comment: '日、周、月、天'
      attribute :repeat_count, :integer, default: 1, comment: '每几周/天'
      attribute :repeat_days, :string, array: true

      enum repeat_type: {
        weekly: 'weekly',
        monthly: 'monthly',
        yearly: 'yearly',
        once: 'once'
      }, _default: 'weekly'
    end

    def selected_ids(date, index)
      case repeat_type
      when 'yearly'
        Array(repeat_days[date.to_s])
      when 'monthly'
        Array(repeat_days[index.to_s])
      when 'weekly'
        Array(repeat_days[index.to_s])
      end
    end

    def repeat_index(datetime)
      case repeat_type
      when 'weekly'
        datetime.days_to_week_start.to_s
      when 'monthly'
        (datetime.day - 1).to_s
      when 'yearly'
        datetime.strftime('%m-%d')
      when 'once'
        datetime.to_fs(:date)
      end
    end

    def next_occurring(start: Time.current, finish: start + 7.days)
      (start.to_date .. finish.to_date).map do |date|
        span = repeat_index(date)
        yield(span, date)
      end.compact
    end

    def next_days(start: Time.current, finish: start + 7.days)
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
end
