class TimeBooking < ApplicationRecord
  include RailsBooking::TimeBooking
end unless defined? TimeBooking
