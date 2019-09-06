module RailsEvent::PlanItem
  extend ActiveSupport::Concern

  included do
    attribute :plan_on, :date
    attribute :time_bookings_count, :integer, default: 0
  
    belongs_to :time_item
    belongs_to :time_list
    belongs_to :plan
    has_many :time_bookings, dependent: :destroy
    has_many :plan_attenders, dependent: :nullify

    belongs_to :place, optional: true
    belongs_to :event, optional: true
    belongs_to :event_item, optional: true
    
    validates :plan_on, presence: true
  
    scope :valid, -> { default_where('plan_on-gte': Date.today) }
  
    after_initialize if: :new_record? do
      if plan
        self.assign_attributes plan.as_json(only: [:event_id, :crowd_id, :place_id, :teacher_id])
      end
    end
    before_validation :sync_repeat_index
  end

  def attenders
    plan_attenders.where(attended: true).pluck(:attender_type, :attender_id).map { |i| i.join('_') }
  end
  
  def sync_repeat_index
    self.repeat_index = self.time_plan.repeat_index(plan_on)
    self.time_list_id = self.time_plan.time_list_id
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

end
