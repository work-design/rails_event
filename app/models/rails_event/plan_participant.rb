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
  
  class_methods do
    
    def participant_types
      return @participant_types if defined? @participant_types
      @participant_types = {}
      PlanParticipant.distinct.pluck(:participant_type).each do |participant_type|
        @participant_types[participant_type.tableize.to_sym] = participant_type
      end
      @participant_types
    end
    
  end
  
end
