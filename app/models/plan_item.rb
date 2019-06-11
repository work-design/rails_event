class PlanItem < ApplicationRecord
  include RailsBooking::PlanItem
end unless defined? PlanItem
