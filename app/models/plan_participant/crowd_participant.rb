class CrowdParticipant < PlanParticipant
  include RailsEvent::PlanParticipant::CrowdParticipant
end unless defined? CrowdParticipant
