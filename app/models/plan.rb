class Plan < ApplicationRecord
  include RailsEvent::Plan
  include RailsEvent::Planning
  include RailsEvent::Recurrence
end unless defined? Plan
