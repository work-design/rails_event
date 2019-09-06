json.extract! event_item,
              :id,
              :title,
              :video_urls,
              :document_urls
json.event event_item.event, :id, :title
