module RailsBooking::TimePlan
  REPEAT = {
    'once' => 0..7,
    'weekly' => 0..7,
    'monthly' => 0..30
  }.freeze
  extend ActiveSupport::Concern
  included do
    attribute :begin_on, :date, default: -> { Date.today }
    attribute :end_on, :date
  
    belongs_to :plan, polymorphic: true
    belongs_to :time_list, optional: true
    has_many :time_items, through: :time_list
    has_many :time_bookings, ->(o){ where(booked_type: o.plan_type) }, foreign_key: :booked_id, primary_key: :plan_id
    has_many :plan_items, ->(o){ where(plan_type: o.plan_type, plan_id: o.plan_id) }, dependent: :delete_all
    
    default_scope -> { order(begin_on: :asc) }
  
    after_commit :sync
  
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

  def toggle(index, time_item_id)
    if repeat_type_changed? || time_list_id_changed?
      self.repeat_days = {}
    end
    
    repeat_days.toggle! index => time_item_id
  end

  def diff_toggle(index, time_item_id)
    if repeat_type_changed? || time_list_id_changed?
      self.repeat_days = {}
    end
    
    repeat_days.diff_toggle index => time_item_id
  end

  def xx
    REPEAT[self.repeat_type]
  end

  def sync(start: Date.today, finish: Date.today + 14.days)
    removes, adds = self.present_days.diff_changes self.next_days(start: start, finish: finish)
  
    removes.each do |date, time_item_ids|
      Array(time_item_ids).each do |time_item_id|
        self.plan_items.where(plan_on: date, time_item_id: time_item_id).delete_all
      end
    end
  
    adds.each do |date, time_item_ids|
      Array(time_item_ids).each do |time_item_id|
        pi = self.plan_items.find_or_initialize_by(plan_on: date, time_item_id: time_item_id)
        pi.save
      end
    end
  
    self
  end

  def present_days
    self.plan_items.order(plan_on: :asc).group_by(&->(i){i.plan_on.to_s}).transform_values! do |v|
      v.map(&:time_item_id)
    end
  end
  
  class_methods do
    
    def recent(date = Date.today)
      r1 = find do |i|
        (i.begin_on <= date) &&
        (i.end_on.blank? ? true : i.end_on >= date)
      end
      return r1 if r1
      
      r2 = find do |i|
        i.begin_on > date
      end
      return r1 if r2
      
      r3 = last
      return r3 if r3
    end
    
  end

end

# note
# 如果已经存在 A ~ B 日期范围内的数据；
# begin_on 位于 [A, B]之间, end_on
