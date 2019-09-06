class TimePlan < ApplicationRecord
  include RailsEvent::TimePlan
  include RailsEvent::Recurrence
  include RailsEvent::PlanItemize
end unless defined? TimePlan
