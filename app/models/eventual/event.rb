module Eventual
  class Event < ApplicationRecord
    include Model::Event
    include Model::Planned
  end
end
