class TimePlan < ApplicationRecord
  include RailsBookingTime

  attribute :booking_on, :date

  belongs_to :room, optional: true
  belongs_to :plan, polymorphic: true
  belongs_to :time_item
  belongs_to :time_list


end
