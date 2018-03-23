module TheBookingLocate
  extend ActiveSupport::Concern

  included do
    #attribute :import_price, :decimal, default: 0

    def self.extra
      {}
    end
  end

  def extra
    {}
  end

end