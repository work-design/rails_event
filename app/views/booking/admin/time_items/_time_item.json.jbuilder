json.extract! time_item, :id, :name
json.start_at time_item.start_at.to_s(:time)
json.finish_at time_item.finish_at.to_s(:time)
