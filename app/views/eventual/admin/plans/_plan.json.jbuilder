json.extract! plan,
              :id,
              :planned_type,
              :planned_id,
              :begin_on,
              :end_on,
              :place_id,
              :repeat_type,
              :repeat_days
json.plan_participants plan.plan_participants do |plan_participant|
  json.extract! plan_participant, :id, :participant_type, :participant_id
end
