class TimeList < ApplicationRecord

  attribute :kind, :string
  belongs_to :organ, optional: true
  has_many :time_items

end
