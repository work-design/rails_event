module RailsEvent::Place
  extend ActiveSupport::Concern
  
  included do
    attribute :name, :string
    attribute :max_members, :integer, default: 0
    
    attribute :plans_count, :integer, default: 0

    belongs_to :organ

    has_many :plans
    
    validates :name, presence: true
    #TimePlan.belongs_to :place, class_name: self.name, foreign_key: :place_id, counter_cache: true, optional: true
  end

end
