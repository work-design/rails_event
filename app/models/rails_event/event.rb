module RailsEvent::Event
  extend ActiveSupport::Concern
  included do
    
    belongs_to :event_taxon, optional: true
  
    has_many :event_items
  
    has_many :event_members, dependent: :destroy
    has_many :crowds, through: :event_members

    has_many :event_grants, dependent: :destroy
  end
  
  def member_type_ids
    event_members.pluck(:member_type, :member_id)
  end

  def save_with_remind
    self.class.transaction do
      self.save!
    end

    return unless self.persisted?

    self.class.transaction do
      EventMemberMailer.assign(self.id).deliver_later
      job = EventMemberMailer.remind(self.id).deliver_later(wait_until: self.event.next_start_at - 1.day)
      self.update(job_id: job.job_id)
    end
  end

  def timestamp
    self.event_members.order(created_at: :desc).first&.created_at.to_i
  end
  
end
