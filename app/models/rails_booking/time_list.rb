class TimeList < ApplicationRecord

  attribute :kind, :string
  attribute :item_minutes, :integer, default: 45

  belongs_to :organ, optional: true
  has_many :time_items, -> { order(start_at: :asc) }

end
