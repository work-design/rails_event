module RailsBooking::TimeList
  extend ActiveSupport::Concern
  included do
    attribute :kind, :string
    attribute :item_minutes, :integer, default: 45
    attribute :interval_minutes, :integer, default: 15
  
    belongs_to :organ, optional: true
    has_many :time_items, -> { order(start_at: :asc) }
    after_update :set_default, if: -> { self.default? && saved_change_to_default? }
  end
  
  def set_default
    self.class.where.not(id: self.id).where(organ_id: self.organ_id).update_all(default: false)
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

  def events(date, day_count = 7)
    default_date = date.to_date
    (default_date .. default_date + day_count).map do |date|
      item_events(date)
    end.flatten
  end

  def item_events(date, selected_ids: [], common_options: {}, selected_options: {})
    time_items.map do |time_item|
      if selected_ids.include?(time_item.id)
        time_item.event(date, selected: true, common_options: common_options, selected_options: selected_options)
      else
        time_item.event(date, common_options: common_options)
      end
    end
  end

  class_methods do
    def default
      self.find_by(default: true)
    end
  end

end
