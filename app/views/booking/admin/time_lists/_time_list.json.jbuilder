json.extract! time_list,
              :id,
              :name,
              :code,
              :default,
              :created_at,
              :updated_at
json.time_items time_list.time_items do |time_item|
  json.extract! time_item, :id, :name
  json.start_at time_item.start_at.to_s(:time)
  json.finish_at time_item.finish_at.to_s(:time)
end
