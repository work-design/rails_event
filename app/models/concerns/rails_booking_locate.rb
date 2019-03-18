module RailsBookingLocate
  extend ActiveSupport::Concern

  included do
    attribute :time_plans_count, :integer, default: 0

    has_many :time_plans
    TimePlan.belongs_to :room, class_name: self.name, foreign_key: :room_id, counter_cache: true
  end


end
