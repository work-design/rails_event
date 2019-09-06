json.extract! plan_attender,
              :id,
              :attended,
              :event_member_id,
              :created_at
json.attender plan_attender.attender,
             :id,
             :name
           
