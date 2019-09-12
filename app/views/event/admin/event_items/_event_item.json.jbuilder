json.extract! event_item,
              :id,
              :name,
              :video_urls,
              :document_urls
json.event event_item.event, :id, :name
