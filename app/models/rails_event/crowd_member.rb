module RailsEdu::CrowdMember
  extend ActiveSupport::Concern
  included do
    belongs_to :crowd, counter_cache: true
    belongs_to :member, polymorphic: true
    belongs_to :agency, optional: true
  
    after_destroy_commit :quit_event
  end
  
  def quit_event
  
  end

end
