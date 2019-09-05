class PlanEvent < ApplicationRecord
  include RailsBooking::PlanEvent
  include RailsBooking::Recurrence
  include RailsBooking::PlanItemize
end unless defined? PlanEvent
