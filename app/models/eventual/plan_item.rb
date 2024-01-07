module Eventual
  class PlanItem < ApplicationRecord
    include Model::PlanItem
    include Inner::Planning
  end
end
