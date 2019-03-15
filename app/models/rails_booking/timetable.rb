class Timetable < ApplicationRecord

  attribute :kind, :string
  belongs_to :organ, optional: true

end
