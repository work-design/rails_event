module RailsBooking::Place
  extend ActiveSupport::Concern
  
  included do
    attribute :name, :string
    attribute :limit_member, :integer
    
    belongs_to :organ
    attribute :time_plans_count, :integer, default: 0

    has_many :time_plans
    #TimePlan.belongs_to :place, class_name: self.name, foreign_key: :place_id, counter_cache: true, optional: true
  end

  def name
    prefix = organ.name_short.presence || organ.name
    "#{prefix} #{super}"
  end

end
