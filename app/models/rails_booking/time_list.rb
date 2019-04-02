class TimeList < ApplicationRecord

  attribute :kind, :string
  attribute :item_minutes, :integer, default: 45

  belongs_to :organ, optional: true
  has_many :time_items, -> { order(start_at: :asc) }
  after_update :set_default, if: -> { self.default? && saved_change_to_default? }

  def set_default
    self.class.where.not(id: self.id).where(organ_id: self.organ_id).update_all(default: false)
  end

end
