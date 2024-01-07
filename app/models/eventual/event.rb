module Eventual
  class Event < ApplicationRecord
    include Model::Event
    include Inner::Plan
    include Inner::Planning
    include Inner::Recurrence
  end
end
