class Seat < ApplicationRecord
  include RailsEvent::Seat
end unless defined? Seat
