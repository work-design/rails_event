class TimePlan < ApplicationRecord
  include RailsBooking::TimePlan
  include RailsBooking::Recurrence
  include RailsBooking::PlanItemize
end unless defined? TimePlan
