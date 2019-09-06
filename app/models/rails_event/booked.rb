module RailsEvent::Booked
  extend ActiveSupport::Concern

  included do
    has_many :booked_times, class_name: 'Booking', as: :booked
  end

end
