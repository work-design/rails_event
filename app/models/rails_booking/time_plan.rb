module RailsBooking::TimePlan
  extend ActiveSupport::Concern
  included do
    include RailsBooking::TimePlan::Recurrence
    REPEAT = {
      'once' => 0..7,
      'weekly' => 0..7,
      'monthly' => 0..30
    }
  
    attribute :begin_on, :date, default: -> { Date.today }
    attribute :end_on, :date
  
    belongs_to :plan, polymorphic: true
    belongs_to :time_list, optional: true
    has_many :time_items, through: :time_list
    has_many :time_bookings, ->(o){ where(booked_type: o.plan_type) }, foreign_key: :booked_id, primary_key: :plan_id
  
    default_scope -> { order(begin_on: :asc) }
  
    after_commit :plan_sync
  
    validates :begin_on, presence: true
    validate :validate_end_on
  end
  
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
  
  def repeat_index(date)
    case repeat_type
    when 'weekly'
      date.days_to_week_start.to_s
    when 'monthly'
      (date.day - 1).to_s
    when 'once'
      date.to_s(:date)
    end
  end

  def selected_ids(date, index)
    case repeat_type
    when 'once'
      Array(self.repeat_days[date.to_s])
    when 'monthly'
      Array(self.repeat_days[index.to_s])
    when 'weekly'
      Array(self.repeat_days[index.to_s])
    end
  end

  def same_scopes
    self.class.where.not(id: self.id).default_where(plan_type: self.plan_type, plan_id: self.plan_id)
  end

  def toggle(date, time_item_id)
    if repeat_type_changed? || time_list_id_changed?
      self.repeat_days = {}
    end
    
    repeat_days.toggle! repeat_index(date) => time_item_id
  end

  def diff_toggle(date, time_item_id)
    if repeat_type_changed? || time_list_id_changed?
      self.repeat_days = {}
    end
    
    repeat_days.diff_toggle repeat_index(date) => time_item_id
  end

  def events
    day_range = REPEAT[self.repeat_type]
   
    day_range.map.with_index do |padding|
      event(default_date + padding, padding)
    end.flatten
  end
  
  def event(date, padding)
    time_list.item_events(date, selected_ids: selected_ids(date, padding), common_options: { time_plan_id: self.id })
  end
  
  def item_event(time_item_id, index)
    time_item = TimeItem.find time_item_id
    date = default_date + index
    time_item.event(date, selected: true, common_options: { time_plan_id: self.id })
  end

  def plan_sync
    plan.sync
  end

end

# note
# 如果已经存在 A ~ B 日期范围内的数据；
# begin_on 位于 [A, B]之间, end_on
