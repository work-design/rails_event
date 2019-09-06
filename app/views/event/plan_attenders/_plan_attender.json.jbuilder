json.extract! plan_attender,
              :id,
              :attended,
              :course_student_id,
              :created_at
json.attender plan_attender.attender,
             :id,
             :name
           
