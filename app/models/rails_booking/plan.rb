module RailsBooking::Plan
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

  def next_occurrences(start: Time.current, finish: start + 14.days, filter_options: {})
    r = []
    time_plans.each do |time_plan|
      r += time_plan.next_occurrences(start: start, finish: finish, filter_options: filter_options)
    end
    r
  end

  def next_days(start: Time.current, finish: start + 14.days)
    r = []
    time_plans.each do |time_plan|
      r << time_plan.next_days(start: start, finish: finish)
    end
    r.to_combine_h
  end

  def sync
    p 'should implement in class'
  end

end
