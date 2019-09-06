json.extract! crowd,
              :id,
              :name
json.members crowd.members do |member|
  json.extract! member, :id, :name
end
