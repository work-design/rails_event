json.date date
json.occurrences items do |i|
  json.id i.id
  json.date i.plan_on.to_s
  json.start_at i.start_at.to_s(:time)
  json.finish_at i.finish_at.to_s(:time)
  #json.present_number i.plan.present_number.to_i
  #json.limit_number i.plan.limit_number.to_i
  json.place i.plan.place&.as_json(only: [:id], methods: [:name])
  #json.crowd i.plan.crowd.as_json(only: [:id, :name])
  #json.booked i.bookings.default_where(filter_options).exists?
end
