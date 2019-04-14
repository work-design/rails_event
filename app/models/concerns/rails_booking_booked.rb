module RailsBookingBooked
  extend ActiveSupport::Concern

  included do
    has_many :booked_times, class_name: 'TimeBooking', as: :booked
  end


end
