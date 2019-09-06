class PlanItem < ApplicationRecord
  include RailsEvent::PlanItem
end unless defined? PlanItem
