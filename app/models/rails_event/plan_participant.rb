module RailsEvent::PlanParticipant
  extend ActiveSupport::Concern

  included do
    belongs_to :planning, polymorphic: true
    
    belongs_to :event_participant, optional: true
    belongs_to :participant, polymorphic: true
    
    after_initialize do
      if self.event_participant
        self.participant = event_participant.participant
      end
    end
  end
  
end
