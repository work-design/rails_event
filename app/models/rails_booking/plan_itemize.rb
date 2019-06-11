module RailsBooking::PlanItemize
  
  
  def next_occurrences(filter_options: {})
    self.plan_items.order(plan_on: :asc).group_by(&->(i){i.plan_on.to_s}).map do |date, items|
      {
        date: date,
        occurrences: items.map do |i|
          {
            id: i.id,
            date: i.plan_on.to_s,
            start_at: i.start_at.to_s(:time),
            finish_at: i.finish_at.to_s(:time),
            present_number: i.plan.present_number,
            limit_number: i.plan.limit_number,
            room: i.plan.room&.as_json(only: [:id], methods: [:name]),
            crowd: i.plan.crowd.as_json(only: [:id, :name]),
            booked: i.booked_times.default_where(filter_options.merge!(booking_on: date, time_item_id: i.id)).exists?
          }
        end
      }
    end
  end
  
  
end
