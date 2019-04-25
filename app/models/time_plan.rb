class TimePlan < ApplicationRecord
  include RailsBooking::TimePlan
end unless defined? TimePlan
