module RailsEvent::Booker
  extend ActiveSupport::Concern

  included do
    has_many :booker_bookings, class_name: 'Booking', as: :booker
  end
  
  
  def confirm_booker_time!(booked)
    p 'implement in application'
  end

end
