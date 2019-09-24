module RailsEvent::Planning
  extend ActiveSupport::Concern
  included do
    has_many :plan_participants, as: :planning, dependent: :delete_all
    accepts_nested_attributes_for :plan_participants

    has_many :crowd_participants, as: :planning
    has_many :normal_participants, class_name: 'PlanParticipant', as: :planning
    
    NormalParticipant.participant_types.each do |participant, participant_type|
      has_many participant, through: :normal_participants, source: :participant, source_type: participant_type
    end
  end
  
  def participant_types
  
    crowd_participants.map do |crowd_participant|
      {
        id: crowd_participant.id,
        participant_type: participant_type,
        participant_name: crowd.name,
        members: crowd.members.as_json(only: [:id, :name])
      }
    end
    
    NormalParticipant.participant_types.map do |participant, participant_type|
      {
        participant_type: participant_type,
        participant_name: PlanParticipant.enum_i18n(:participant_type, participant_type),
        members: send(participant)
      }
    end
  end
  
end
