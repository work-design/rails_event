class TimeItem < ApplicationRecord
  acts_as_list scope: :time_list_id

  attribute :start_at, :time
  attribute :finish_at, :time

  belongs_to :time_list


  def name
    "#{start_at} ~ #{finish_at}"
  end

end
