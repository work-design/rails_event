module RailsEvent::EventItem
  extend ActiveSupport::Concern
  included do
    belongs_to :event
    belongs_to :author, class_name: 'Member', optional: true
    has_many :event_item_members
    has_many :members, through: :event_item_members, source_type: 'Profile'
  
    has_many_attached :videos
    has_many_attached :documents
  end
  
  
  def video_urls
    videos.map(&:service_url)
  end
  
  def document_urls
    documents.map(&:service_url)
  end
  
end
