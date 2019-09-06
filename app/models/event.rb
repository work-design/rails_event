class Event < ApplicationRecord
  include RailsEvent::Event
  include RailsEvent::Planned
  include RailsEvent::PlanItemize
end unless defined? Event
