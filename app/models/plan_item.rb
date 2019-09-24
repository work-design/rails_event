class PlanItem < ApplicationRecord
  include RailsEvent::PlanItem
  include RailsEvent::Planning
end unless defined? PlanItem
