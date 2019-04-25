module RailsBooking::Booker
  extend ActiveSupport::Concern

  included do
    has_many :booker_times, class_name: 'TimeBooking', as: :booker
  end


end
