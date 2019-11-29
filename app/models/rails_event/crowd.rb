module RailsEvent::Crowd
  extend ActiveSupport::Concern
  
  included do
    attribute :name, :string
    attribute :member_type, :string, default: 'Profile'
    attribute :crowd_members_count, :integer, default: 0
    
    belongs_to :organ, optional: true
    has_many :crowd_members
    has_many :members, through: :crowd_members, source_type: 'Profile'
    has_many :event_participants
    
    validates :name, presence: true
    
    has_one_attached :logo
  end
  
end
