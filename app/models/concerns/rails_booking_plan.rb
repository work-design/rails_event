module RailsBookingPlan
  extend ActiveSupport::Concern

  included do
    has_many :time_plans
  end


end
