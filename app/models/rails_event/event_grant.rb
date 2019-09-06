module RailsEvent::EventGrant
  extend ActiveSupport::Concern
  included do
    belongs_to :event
  end
  
end
