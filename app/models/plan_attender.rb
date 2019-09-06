class PlanAttender < ApplicationRecord
  include RailsEvent::PlanAttender
end unless defined? PlanAttender
