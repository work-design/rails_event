class TimeBooking < ApplicationRecord
  attribute :room_id, :integer
  attribute :booking_on, :date

  belongs_to :room, optional: true
  belongs_to :booking, polymorphic: true
  belongs_to :time_item, optional: true
  belongs_to :time_list, optional: true
  has_many :time_plans, ->(o){ where(plan_type: o.booking_type) }, foreign_key: :booking_id, primary_key: :plan_id

  delegate :start_at, :finish_at, to: :time_item, allow_nil: true

end
