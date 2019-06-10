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

  def sync(start: Date.today, finish: Date.today + 14.days)
    removes, adds = self.present_days.diff_changes self.next_days(start: start, finish: finish)
  
    removes.each do |date, time_item_ids|
      Array(time_item_ids).each do |time_item_id|
        self.plan_items.where(plan_on: date, time_item_id: time_item_id).delete_all
      end
    end
  
    adds.each do |date, time_item_ids|
      Array(time_item_ids).each do |time_item_id|
        cp = self.plan_items.find_or_initialize_by(plan_on: date, time_item_id: time_item_id)
        cp.save
      end
    end
  
    self
  end

  def present_days
    self.plan_items.order(plan_on: :asc).group_by(&->(i){i.plan_on.to_s}).transform_values! do |v|
      v.map(&:time_item_id)
    end
  end

end
