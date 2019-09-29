module RailsEvent::Place
  extend ActiveSupport::Concern
  
  included do
    attribute :name, :string
    attribute :description, :string
    attribute :seats_count, :integer, default: 0
    attribute :plans_count, :integer, default: 0

    belongs_to :organ
    has_many :plans
    
    validates :name, presence: true
  end

end
