class EventMember < ApplicationRecord
  include RailsEvent::EventMember
end unless defined? EventMember
