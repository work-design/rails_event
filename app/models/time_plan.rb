class TimePlan < ApplicationRecord
  include RailsBooking::TimePlan
  include RailsBooking::Recurrence
end unless defined? TimePlan
