json.extract! event,
              :id,
              :name
json.event_taxon event.event_taxon, :id, :name
json.event_items event.event_items do |event_item|
  json.extract! event_item, :id, :name, :video_urls, :document_urls
end
