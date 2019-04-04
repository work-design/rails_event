class TimeList < ApplicationRecord

  attribute :kind, :string
  attribute :item_minutes, :integer, default: 45
  attribute :interval_minutes, :integer, default: 15

  belongs_to :organ, optional: true
  has_many :time_items, -> { order(start_at: :asc) }
  after_update :set_default, if: -> { self.default? && saved_change_to_default? }

  def set_default
    self.class.where.not(id: self.id).where(organ_id: self.organ_id).update_all(default: false)
  end

  def gcd
    g = item_minutes.gcd(interval_minutes)
    (Time.current.beginning_of_day + g.minutes).to_s(:time)
  end

  def total
    g = item_minutes + interval_minutes
    (Time.current.beginning_of_day + g.minutes).to_s(:time)
  end

  def start_at
    if time_items.size > 0
      time_items[0].start_at.to_s(:time)
    else
      '08:00'
    end
  end

  def finish_at
    if time_items.size > 0
      time_items[-1].finish_at.to_s(:time)
    else
      '18:00'
    end
  end

end
