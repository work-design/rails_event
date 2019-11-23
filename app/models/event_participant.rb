class EventParticipant < ApplicationRecord
  include RailsEvent::EventParticipant
  include RailsCom::StateMachine
end unless defined? EventParticipant
