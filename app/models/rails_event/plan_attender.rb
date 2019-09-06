module RailsBooking::PlanAttender
  extend ActiveSupport::Concern
  
  included do
    attribute :attended, :boolean, default: false

    belongs_to :attender, polymorphic: true
    belongs_to :plan_item
    
    enum state: {
      absent: 'absent'  # 请假
    }

    after_initialize if: :new_record? do
      if plan_item
        self.assign_attributes plan_item.as_json(only: [:event_id, :crowd_id, :place_id])
      end
    end
  end

end
