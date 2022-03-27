module Eventual
  class Event < ApplicationRecord
    include Model::Event
    include Ext::Planned
  end
end
