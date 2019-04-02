json.extract! time_list,
              :id,
              :name,
              :code,
              :default,
              :created_at,
              :updated_at
json.time_items time_list.time_items, :id, :name, :start_at, :finish_at
