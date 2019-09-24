module RailsEvent::PlanParticipant
  extend ActiveSupport::Concern

  included do
    belongs_to :planning, polymorphic: true
    
    belongs_to :event_participant, optional: true
    belongs_to :participant, polymorphic: true
    
    after_initialize if: :new_record? do
      if self.event_participant
        self.participant = event_participant.participant
      end
      if self.participant_type == 'Crowd'
        self.type = 'CrowdParticipant'
      else
        self.type = 'NormalParticipant'
      end
    end
  end
  
  
  
end
