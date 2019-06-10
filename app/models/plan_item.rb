class PlanItem < ApplicationRecord
  include RailsBooking::Booked
  include RailsBooking::PlanItem
end unless defined? PlanItem
