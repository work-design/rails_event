module RailsBooking::PlanParticipant
  extend ActiveSupport::Concern

  included do
    belongs_to :plan_time
    belongs_to :participant, polymorphic: true
  end
  
end
