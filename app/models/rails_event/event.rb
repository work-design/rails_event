module RailsEdu::Course
  extend ActiveSupport::Concern
  included do
    
    belongs_to :event_taxon, optional: true
  
    has_many :event_items
  
    has_many :event_members, dependent: :destroy
    has_many :crowds, through: :event_members

    has_many :event_grants, dependent: :destroy
  end
  
  def student_type_ids
    course_students.pluck(:student_type, :student_id)
  end

  def save_with_remind
    self.class.transaction do
      self.save!
    end

    return unless self.persisted?

    self.class.transaction do
      CourseStudentMailer.assign(self.id).deliver_later
      job = CourseStudentMailer.remind(self.id).deliver_later(wait_until: self.course.next_start_at - 1.day)
      self.update(job_id: job.job_id)
    end
  end

  def timestamp
    self.course_students.order(created_at: :desc).first&.created_at.to_i
  end
  
end
