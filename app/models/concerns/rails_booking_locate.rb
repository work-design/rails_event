module RailsBookingLocate
  extend ActiveSupport::Concern

  included do
    belongs_to :location, optional: true
    belongs_to :room, optional: true
  end

  def extra
    {}
  end

end
