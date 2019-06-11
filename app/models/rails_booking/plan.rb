module RailsBooking::Plan
  extend ActiveSupport::Concern

  included do
    attribute :title, :string
    
    has_many :time_plans, as: :plan
    has_many :plan_items, as: :plan
  end

  def default_time_plan(params)
    time_plans.find_or_initilaze_by(
      room_id: params[:room_id],
      begin_on: params[:begin_on],
      end_on: params[:end_on]
    )
  end

end
