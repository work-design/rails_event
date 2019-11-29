module RailsEvent::EventTaxon
  extend ActiveSupport::Concern
  included do
    attribute :name, :string
    
    belongs_to :organ, optional: true
    has_many :events, dependent: :nullify
  end
  
end
