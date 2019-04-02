class TimePlan < ApplicationRecord
  include RailsBookingTime

  attribute :room_id, :integer

  belongs_to :room, optional: true
  belongs_to :plan, polymorphic: true
  belongs_to :time_item
  belongs_to :time_list
  delegate :start_at, :finish_at, to: :time_item, allow_nil: true


end
