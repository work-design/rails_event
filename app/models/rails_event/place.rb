module RailsEvent::Place
  extend ActiveSupport::Concern
  
  included do
    attribute :name, :string
    attribute :description, :string
    attribute :color, :string
    attribute :seats_count, :integer, default: 0
    attribute :plans_count, :integer, default: 0

    belongs_to :organ, optional: true
    belongs_to :area, optional: true
    belongs_to :place_taxon
    has_many :plans
    
    validates :name, presence: true
  end

end
