class EventParticipant < ApplicationRecord
  include RailsEvent::EventParticipant
end unless defined? EventParticipant
