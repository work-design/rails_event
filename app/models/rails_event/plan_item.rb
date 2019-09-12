module RailsEvent::PlanItem
  extend ActiveSupport::Concern

  included do
    attribute :plan_on, :date
    attribute :bookings_count, :integer, default: 0

    belongs_to :time_item
    belongs_to :time_list
    belongs_to :plan
    has_many :bookings, dependent: :destroy
    has_many :plan_participants, foreign_key: :plan_id, primary_key: :plan_id
    has_many :plan_attenders, dependent: :nullify

    belongs_to :place, optional: true
    belongs_to :event, optional: true
    belongs_to :event_item, optional: true
    
    validates :plan_on, presence: true
    
    default_scope -> { order(plan_on: :asc) }
    scope :valid, -> { default_where('plan_on-gte': Date.today) }
    
    before_validation :sync_from_plan
  end

  def attenders
    plan_attenders.where(attended: true).pluck(:attender_type, :attender_id).map { |i| i.join('_') }
  end
  
  def sync_from_plan
    if plan
      self.place_id = plan.place_id
      self.repeat_index = self.plan.repeat_index(plan_on)
    end
    if time_item
      self.time_list_id = time_item.time_list_id
    end
  end
  
  def start_at
    time_item.start_at.change(plan_on.parts)
  end
  
  def finish_at
    time_item.finish_at.change(plan_on.parts)
  end

  def to_event
    {
      id: id,
      start: start_at.strftime('%FT%T'),
      end: finish_at.strftime('%FT%T'),
      title: "#{place&.name} #{plan.title}",
      extendedProps: {
        title: plan.title,
        time_item_id: time_item_id,
        plan: plan_on,
        place: place.as_json(only: [:id], methods: [:name]),
        crowd: crowd.as_json(only: [:id, :name])
      }
    }
  end
  
  class_methods do
    
    def to_events(start_on: Date.today.beginning_of_week, finish_on: Date.today.end_of_week, **options)
      options.merge! 'plan_on-gte': start_on, 'plan_on-lte': finish_on
      cols = (start_on.to_date .. finish_on.to_date).map { |i| [i, []] }.to_h
      if options[:time_list_id]
        time_list = TimeList.find options[:time_list_id]
      elsif options.key?(:organ_id)
        time_list = TimeList.where(organ_id: options[:organ_id]).default
        options.merge! time_list_id: time_list&.id
      else
        time_list = TimeList.where(organ_id: nil).default
        options.merge! time_list_id: time_list&.id
      end
      rows = time_list.time_items.map { |i| [i, []] }.to_h
  
      plan_items = PlanItem.includes(:time_item).default_where(options).group_by(&->(i){i.plan_on})
      plan_items.each do |date, items|
        t_items = items.group_by(&->(i){i.time_item})
        plan_items[date] = t_items.reverse_merge rows
      end
      plan_items.reverse_merge! cols
    end
    
  end

end
