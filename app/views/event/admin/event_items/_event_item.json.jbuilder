json.extract! event_item,
              :id,
              :name
json.event event_item.event, :id, :name
json.videos event_item.videos do |video|
  json.extract! video, :service_url, :filename
end
json.documents event_item.documents do |document|
  json.extract! document, :service_url, :filename
end
