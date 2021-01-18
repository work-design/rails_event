module Eventual
  class EventParticipant < ApplicationRecord
    include Model::EventParticipant
    include Com::Ext::StateMachine
  end
end
