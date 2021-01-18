module Eventual
  module Model::Booked
    extend ActiveSupport::Concern

    included do
      has_many :booked_bookings, class_name: 'Booking', as: :booked
    end

  end
end
