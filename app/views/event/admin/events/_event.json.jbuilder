json.extract! event,
              :id,
              :name
json.event_taxon event.event_taxon, :id, :name
json.event_items event.event_items do |event_item|
  json.extract! event_item, :id, :name
  json.videos event_item.videos do |video|
    json.extract! video, :service_url, :filename
  end
  json.documents event_item.documents do |document|
    json.extract! document, :service_url, :filename
  end
end
