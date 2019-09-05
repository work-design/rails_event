class Room < ApplicationRecord
  include RailsBooking::Room
end unless defined? Room
