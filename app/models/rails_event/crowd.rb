module RailsEdu::Crowd
  extend ActiveSupport::Concern
  
  included do
    attribute :member_type, :string
    
    has_many :crowd_members
    has_many :students, through: :crowd_students, source_type: 'Profile'
    has_many :course_crowds, dependent: :destroy
    has_many :course_students, through: :course_crowds
  end
  
end
