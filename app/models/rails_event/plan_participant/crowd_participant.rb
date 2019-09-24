module RailsEvent::PlanParticipant::CrowdParticipant
  extend ActiveSupport::Concern
  included do
    belongs_to :crowd, foreign_key: :participant_id
    has_many :members, through: :crowd
  end
  
end
