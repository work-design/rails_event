module RailsBooking::TimeItem
  extend ActiveSupport::Concern
  included do
    acts_as_list scope: :time_list_id
  
    attribute :start_at, :time
    attribute :finish_at, :time
  
    belongs_to :time_list
    has_one :last_item, -> { order(finish_at: :desc) }, class_name: self.name, foreign_key: :time_list_id, primary_key: :time_list_id
    validate :validate_finish_at
  end
  
  def validate_finish_at
    return if finish_at.nil? && start_at.nil?
    unless finish_at > start_at
      self.errors.add :finish_at, 'Finish At Should large then Start at time!'
    end
  end

  def name
    "#{start_at.to_s(:time)} ~ #{finish_at.to_s(:time)}"
  end

  def init_start_at
    if time_list && last_item
      last_item.finish_at + time_list.interval_minutes.minutes
    else
      Time.current
    end
  end

  def init_finish_at
    if time_list
      self.init_start_at + time_list.item_minutes.minutes
    else
      self.init_start_at + 45.minutes
    end
  end

  def event(date, selected: false, selected_options: {})
    r = {
      id: id,
      start: start_at.change(date.parts).strftime('%FT%T'),
      end: finish_at.change(date.parts).strftime('%FT%T'),
      rendering: 'background',
      color: '#ff9f89'
    }
    if selected
      r.merge!(
        color: '#2A92CA',
        rendering: nil,
        **selected_options
      )
    else
      r
    end
  end

end
