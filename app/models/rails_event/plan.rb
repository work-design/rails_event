module RailsBooking::Plan
  extend ActiveSupport::Concern

  included do
    attribute :title, :string

    belongs_to :planned, polymorphic: true

    has_many :plan_times
    accepts_nested_attributes_for :plan_times
  end

  

end
