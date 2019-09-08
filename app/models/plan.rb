class Plan < ApplicationRecord
  include RailsEvent::Plan
  include RailsEvent::Recurrence
end unless defined? Plan
