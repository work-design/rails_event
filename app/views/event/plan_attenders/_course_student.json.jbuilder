json.extract! event_member,
              :id,
              :state,
              :created_at
json.member event_member.member,
             :id,
             :real_name,
             :nick_name,
             :age,
             :birthday
json.attended @plan_item.members.include?("#{event_member.member_type}_#{event_member.member_id}")
