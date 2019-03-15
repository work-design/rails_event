class Room < ApplicationRecord

  attribute :room_number, :string
  belongs_to :location
  belongs_to :organ, optional: true


end

# :office, :string
# :meeting_root, :string
#
