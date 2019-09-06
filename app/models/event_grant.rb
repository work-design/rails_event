class EventGrant < ApplicationRecord
  include RailsEvent::EventGrant
end unless defined? EventGrant
