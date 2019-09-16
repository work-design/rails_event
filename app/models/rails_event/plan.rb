module RailsEvent::Plan
  REPEAT = {
    'once' => 0..6,
    'weekly' => 0..6,
    'monthly' => 0..30
  }.freeze
  extend ActiveSupport::Concern
  included do
    attribute :begin_on, :date, default: -> { Date.today }
    attribute :end_on, :date
    attribute :title, :string
    attribute :planned_type, :string, default: 'Event'

    belongs_to :planned, polymorphic: true
    belongs_to :time_list
    belongs_to :place, optional: true
    has_many :time_items, through: :time_list
    has_many :time_bookings, ->(o){ where(booked_type: o.plan_type) }, foreign_key: :booked_id, primary_key: :plan_id
    has_many :plan_items, dependent: :destroy

    has_many :plan_participants, as: :planning, dependent: :delete_all
    accepts_nested_attributes_for :plan_participants
    
    default_scope -> { order(begin_on: :asc) }
    validates :begin_on, presence: true
  end
  
  def selected_ids(date, index)
    case repeat_type
    when 'yearly'
      Array(self.repeat_days[date.to_s])
    when 'monthly'
      Array(self.repeat_days[index.to_s])
    when 'weekly'
      Array(self.repeat_days[index.to_s])
    end
  end

  def same_scopes
    self.class.where.not(id: self.id).default_where(planned_type: self.plan_type, planned_id: self.plan_id)
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

  def sync(start: Date.today.beginning_of_week, finish: Date.today.end_of_week)
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
      default_where('begin_on-lte': date).unscope(:order).order(begin_on: :desc).first
    end

    def xx
      Date::DAYS_INTO_WEEK.map do |name, index|
        if Date.beginning_of_week == :monday
          i = (index - 1) % 7
        else
          i = index
        end
        [i, I18n.t("date.week_day.#{name}.name")]
      end.sort.to_h
    end
    
  end

end

# note
# 如果已经存在 A ~ B 日期范围内的数据；
# begin_on 位于 [A, B]之间, end_on
