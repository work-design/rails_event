module Eventual
  class Plan < ApplicationRecord
    include Model::Plan
    include Model::Planning
    include Model::Recurrence
  end
end
