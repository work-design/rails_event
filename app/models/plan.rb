class Plan < ApplicationRecord
  include RailsBooking::Plan
end unless defined? Plan
