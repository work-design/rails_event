module RailsEvent::Crowd
  extend ActiveSupport::Concern
  
  included do
    attribute :member_type, :string, default: 'Profile'
    
    has_many :crowd_members
    has_many :members, through: :crowd_members, source_type: 'Profile'
    has_many :event_participants
    
    has_one_attached :logo
  end
  
end
