class PlanParticipant < ApplicationRecord
  include RailsBooking::PlanParticipant
end unless defined? PlanParticipant
