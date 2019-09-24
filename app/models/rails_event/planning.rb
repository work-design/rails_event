module RailsEvent::Planning
  extend ActiveSupport::Concern
  included do
    has_many :plan_participants, as: :planning, dependent: :delete_all
    accepts_nested_attributes_for :plan_participants

    PlanParticipant.participant_types.each do |participant, participant_type|
      has_many participant, through: :plan_participants, source: :participant, source_type: participant_type
    end
  end
  
  def participant_types
    PlanParticipant.participant_types.map do |participant, participant_type|
      if participant == :crowds
        send(participant).map do |crowd|
          {
            participant_type: participant_type,
            participant_name: crowd.name,
            members: crowd.members.as_json(only: [:id, :name])
          }
        end
      else
        {
          participant_type: participant_type,
          participant_name: PlanParticipant.enum_i18n(:participant_type, participant_type),
          members: send(participant)
        }
      end
    end
  end
  
end
