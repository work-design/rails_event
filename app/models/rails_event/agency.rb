module RailsEvent::Agency
  extend ActiveSupport::Concern
  
  included do
    has_many :crowd_members
    has_many :crowds, through: :crowd_students
  end

  def join_crowd(crowd_id)
    cs = self.crowd_members.build
    cs.member = client
    cs.crowd_id = crowd_id
    cs.save
  end

end
