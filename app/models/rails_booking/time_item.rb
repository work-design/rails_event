class TimeItem < ApplicationRecord
  acts_as_list scope: :time_list_id

  attribute :start_at, :string
  attribute :finish_at, :string

  belongs_to :time_list


end
