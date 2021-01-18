module Eventual
  class PlanItem < ApplicationRecord
    include Model::PlanItem
    include Model::Planning
  end
end
