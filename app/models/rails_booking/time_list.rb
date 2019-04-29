module RailsBooking::TimeList
  extend ActiveSupport::Concern
  included do
    include TimeListCalendar
    attribute :kind, :string
    attribute :item_minutes, :integer, default: 45
    attribute :interval_minutes, :integer, default: 15
  
    belongs_to :organ, optional: true
    has_many :time_items, -> { order(start_at: :asc) }
    after_update :set_default, if: -> { self.default? && saved_change_to_default? }
  end
  
  def set_default
    self.class.where.not(id: self.id).where(organ_id: self.organ_id).update_all(default: false)
  end
  
  class_methods do
    def default
      self.find_by(default: true)
    end
  end

end
