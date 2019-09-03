class PlanAttender < ApplicationRecord
  include RailsBooking::PlanAttender
end unless defined? PlanAttender
