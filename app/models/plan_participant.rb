class PlanParticipant < ApplicationRecord
  include RailsEvent::PlanParticipant
end unless defined? PlanParticipant
