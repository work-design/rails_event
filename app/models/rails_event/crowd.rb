module RailsEvent::Crowd
  extend ActiveSupport::Concern
  
  included do
    attribute :member_type, :string
    
    has_many :crowd_members
    has_many :members, through: :crowd_members, source_type: 'Profile'
    has_many :event_crowds, dependent: :destroy
    has_many :event_members, through: :event_crowds
    
    has_one_attached :logo
  end
  
end
