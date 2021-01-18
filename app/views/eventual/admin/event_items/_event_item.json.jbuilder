json.extract!(
  event_item,
  :id,
  :name
)
json.event event_item.event, :id, :name
json.videos event_item.videos do |video|
  json.extract! video, :id, :service_url, :filename
end
json.documents event_item.documents do |document|
  json.extract! document, :id, :service_url, :filename
end
