module RailsEvent::EventTaxon
  extend ActiveSupport::Concern
  included do
    has_many :events, dependent: :nullify
  end
  
end
