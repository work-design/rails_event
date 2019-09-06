class Plan < ApplicationRecord
  include RailsEvent::Plan
  include RailsEvent::Recurrence
  include RailsEvent::PlanItemize
end unless defined? Plan
