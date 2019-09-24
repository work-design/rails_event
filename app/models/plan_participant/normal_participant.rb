class NormalParticipant < PlanParticipant
  include RailsEvent::PlanParticipant::NormalParticipant
end unless defined? NormalParticipant
