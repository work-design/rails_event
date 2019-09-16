json.extract! plan_item,
              :id,
:planned_type,
:planned_id,
              :plan_on,
              :start_at,
              :finish_at,
              :qrcode_url
json.plan_participants plan_item.plan_participants do |plan_participant|
  json.extract! plan_participant, :id, :participant_type, :participant_id
end
