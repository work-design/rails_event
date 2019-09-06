class PlanTime < ApplicationRecord
  include RailsBooking::PlanTime
  include RailsBooking::Recurrence
  include RailsBooking::PlanItemize
end unless defined? PlanTime
