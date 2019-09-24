json.extract! plan_item,
              :id,
              :planned_type,
              :planned_id,
              :plan_on,
              :place_id,
              :start_at,
              :finish_at,
              :qrcode_url
json.participants PlanParticipant.participant_types do |participant, participant_type|
  if participant == :crowds
    plan_item.send(participant).each do |crowd|
      json.participant_type participant_type
      json.participant_name crowd.name
    end
  end
end
