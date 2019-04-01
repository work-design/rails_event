module RailsBookingPlan
  extend ActiveSupport::Concern

  included do
    has_many :time_plans, as: :plan
  end


end
