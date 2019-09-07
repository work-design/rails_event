class Booking < ApplicationRecord
  include RailsEvent::Booking
end unless defined? Booking
