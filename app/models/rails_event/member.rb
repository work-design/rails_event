module RailsEvent::Member
  extend ActiveSupport::Concern
  
  included do
    has_many :course_students, as: :student, dependent: :destroy
    has_many :courses, through: :course_students

    has_many :crowd_members, as: :member, dependent: :destroy
    has_many :crowds, through: :crowd_members

    has_many :plan_members, as: :member, dependent: :destroy
    has_many :plan_attenders, as: :attender, dependent: :destroy
  end

  
end
