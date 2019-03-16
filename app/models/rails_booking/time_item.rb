class TimeItem < ApplicationRecord
  acts_as_list scope: :time_list_id
  belongs_to :time_list


end
