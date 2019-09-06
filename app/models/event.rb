class Event < ApplicationRecord
  include RailsEvent::Event
  include RailsBooking::Planned
  include RailsBooking::PlanItemize
end unless defined? Event
