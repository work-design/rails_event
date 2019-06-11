module RailsBooking::PlanAttender
  extend ActiveSupport::Concern
  
  included do
    attribute :attended, :boolean, default: false

    belongs_to :attender, polymorphic: true
    belongs_to :plan_item
    
    enum state: {
      absent: 'absent'  # 请假
    }
  end

end
