class EventCrowd < ApplicationRecord
  include RailsEvent::EventCrowd
end unless defined? EventCrowd
