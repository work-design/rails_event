class TimeBooking < ApplicationRecord
  attribute :room_id, :integer
  attribute :booking_on, :date

  belongs_to :time_item
  belongs_to :time_list
  belongs_to :booker, polymorphic: true
  belongs_to :booked, polymorphic: true, optional: true
  belongs_to :room, optional: true

  has_many :time_plans, ->(o){ where(plan_type: o.booked_type) }, foreign_key: :booking_id, primary_key: :plan_id

  delegate :start_at, :finish_at, to: :time_item, allow_nil: true

  before_validation :sync_time_list_id

  def sync_time_list_id
    self.time_list_id = self.time_item.time_list_id
  end

end
