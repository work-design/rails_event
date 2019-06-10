module RailsBooking::PlanItem
  extend ActiveSupport::Concern

  included do
    attribute :plan_on, :date
    attribute :time_bookings_count, :integer, default: 0
  
    belongs_to :plan, polymorphic: true
    belongs_to :time_item
    
    validates :plan_on, presence: true
  
    scope :valid, -> { default_where('plan_on-gte': Date.today) }
  
    after_initialize if: :new_record? do
      if plan
        self.assign_attributes plan.extra_columns
      end
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
      title: "#{room.name} #{plan.title}",
      extendedProps: {
        title: plan.title,
        time_item_id: time_item_id,
        plan: plan_on,
        course_crowd_id: course_crowd_id,
        room: room.as_json(only: [:id], methods: [:name]),
        crowd: course_crowd.crowd.as_json(only: [:id, :name])
      }
    }
  end

end
