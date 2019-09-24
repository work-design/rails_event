module RailsEvent::PlanAttender
  extend ActiveSupport::Concern
  
  included do
    attribute :attended, :boolean, default: false
    
    belongs_to :plan_participant, optional: true
    belongs_to :attender, polymorphic: true
    belongs_to :plan_item
    
    enum state: {
      absent: 'absent'  # 请假
    }

    after_initialize if: :new_record? do
      if plan_item
        self.assign_attributes plan_item.as_json(only: [:place_id])
      end
      if plan_participant
        self.attender = plan_participant.participant
      end
    end
  end

end
