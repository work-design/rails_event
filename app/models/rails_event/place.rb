module RailsEvent::Place
  extend ActiveSupport::Concern
  
  included do
    attribute :name, :string
    attribute :max_members, :integer, default: 0
    attribute :plans_count, :integer, default: 0

    belongs_to :organ
    has_many :plans
    
    validates :name, presence: true
  end

end
