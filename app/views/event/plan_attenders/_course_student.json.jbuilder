json.extract! event_participant,
              :id,
              :state,
              :created_at
json.member event_participant.member,
             :id,
             :real_name,
             :nick_name,
             :age,
             :birthday
json.attended @plan_item.members.include?("#{event_participant.member_type}_#{event_participant.member_id}")
