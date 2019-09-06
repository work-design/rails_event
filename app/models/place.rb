class Place < ApplicationRecord
  include RailsBooking::Place
end unless defined? Place
