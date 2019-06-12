json.plan_item @plan_item, partial: 'booking/plan_items/plan_item', as: :plan_item
json.course @plan_item.course, :id, :title
json.course_students @course_students, partial: 'course_student', as: :course_student
if @plan_item&.lesson
  json.lesson @plan_item.lesson, :id, :title
end
