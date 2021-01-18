json.extract! plan_attender,
              :id,
              :attended,
              :created_at
json.attender plan_attender.attender,
             :id,
             :name,
             :birthday
           
