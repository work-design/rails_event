json.date date
json.time_items items do |time_item, plan_items|
  json.id time_item.id
  json.start_at time_item.start_at.to_s(:time)
  json.finish_at time_item.finish_at.to_s(:time)
  json.events plan_items do |plan_item|
    #json.present_number i.plan.present_number.to_i
    #json.limit_number i.plan.limit_number.to_i
    json.place plan_item.place&.as_json(only: [:id], methods: [:name])
    json.planned plan_item.plan.planned.as_json(only: [:id, :title])
    json.participants plan_item.plan_participants.as_json(only: [:participant_type])
    
    #json.booked i.bookings.default_where(filter_options).exists?
  end
end
