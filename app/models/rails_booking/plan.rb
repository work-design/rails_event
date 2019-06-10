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

  def next_occurrences(start: Time.current, finish: start + 14.days, filter_options: {})
    time_plans.inject([]) do |memo, time_plan|
      memo += time_plan.next_occurrences(start: start, finish: finish, filter_options: filter_options)
    end
  end

  def next_days(start: Time.current, finish: start + 14.days)
    time_plans.map do |time_plan|
      time_plan.next_days(start: start, finish: finish)
    end.to_combine_h
  end

end
