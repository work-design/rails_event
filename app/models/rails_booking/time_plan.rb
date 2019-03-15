class TimePlan < ApplicationRecord

  attribute :booking_on, :date
  belongs_to :organ, optional: true
  belongs_to :room
  belongs_to :timetable


end
