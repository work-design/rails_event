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
    PlanParticipant.participant_types do |participant, participant_type|
      if participant == :crowds
        plan_item.send(participant).each do |crowd|
          {
            participant_type: participant_type,
            participant_name: crowd.name,
            members: crowd.members.as_json(only: [:id, :name])
          }
        end
      end
    end
  end
  
end
