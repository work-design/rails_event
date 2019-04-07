module RailsBookingPlan
  extend ActiveSupport::Concern

  included do
    has_many :time_plans, as: :plan
  end


  def default_time_plan(params)
    time_plans.find_or_initilaze_by(
      room_id: params[:room_id],
      begin_on: params[:begin_on],
      end_on: params[:end_on]
    )
  end

end
