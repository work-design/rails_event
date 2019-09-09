class Event < ApplicationRecord
  include RailsEvent::Event
  include RailsEvent::Planned
end unless defined? Event
