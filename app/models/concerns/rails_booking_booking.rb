module RailsBookingBooking
  extend ActiveSupport::Concern

  included do
    has_many :time_bookings, as: :booker
  end


end
