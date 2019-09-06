module RailsBooking::PlanMember
  extend ActiveSupport::Concern

  included do
    belongs_to :plan_time
    
    belongs_to :event_member
    belongs_to :member, polymorphic: true
    
    after_initialize do
      if self.event_member
        self.member_type = event_member.member_type
        self.member_id = event_member.member_id
      end
    end
  end
  
end
