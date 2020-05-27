module RailsEvent::EventGrant
  extend ActiveSupport::Concern

  included do
    attribute :grant_kind, :string
    attribute :grant_column, :string
    attribute :filter, :json, default: {}

    belongs_to :event
  end

end
