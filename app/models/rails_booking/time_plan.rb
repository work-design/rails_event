class TimePlan < ApplicationRecord
  include TimePlanRecurrence
  REPEAT = {
    'once' => 7,
    'weekly' => 7,
    'monthly' => 31
  }

  attribute :room_id, :integer
  attribute :begin_on, :date, default: -> { Date.today }
  attribute :end_on, :date

  belongs_to :room, optional: true
  belongs_to :plan, polymorphic: true
  belongs_to :time_list, optional: true
  has_many :time_items, through: :time_list

  default_scope -> { order(begin_on: :asc) }

  validates :begin_on, presence: true
  validate :validate_end_on

  def validate_end_on
    return if end_on.nil?
    r1 = same_scopes.default_where('begin_on-lte': self.begin_on, 'end_on-gte': self.begin_on).exists?
    r2 = same_scopes.default_where('begin_on-lte': self.end_on, 'end_on-gte': self.end_on).exists?
    r3 = same_scopes.where(end_on: nil).exists?
    if r1 || r2 || r3
      self.errors.add :end_on, "date range is not valid, r1: #{r1}, r2: #{r2}, r3:#{r3}"
    end
    unless end_on > begin_on
      self.errors.add :end_on, 'Finish At Should large then Start at time!'
    end
  end

  def default_date
    case self.repeat_type
    when 'once'
      self.begin_on
    when 'weekly', 'monthly'
      FullCalendarHelper.default_date(repeat_type: repeat_type)
    end
  end

  def same_scopes
    self.class.where.not(id: self.id).default_where(
      {
        plan_type: self.plan_type,
        plan_id: self.plan_id,
        room_id: self.room_id
      },
      { room_id: { allow: nil } }
    )
  end

  def selected_ids(date, index)
    case repeat_type
    when 'once'
      Array(self.repeat_days[date.to_s])
    when 'monthly'
      Array(self.repeat_days[(index + 1).to_s])
    when 'weekly'
      Array(self.repeat_days[(index).to_s])
    end
  end

  def events
    day_count = REPEAT[self.repeat_type]
    (default_date .. default_date + day_count).map.with_index do |date, index|
      time_list.item_events(date, selected_ids: selected_ids(date, index))
    end.flatten
  end

end

# note
# 如果已经存在 A ~ B 日期范围内的数据；
# begin_on 位于 [A, B]之间, end_on
