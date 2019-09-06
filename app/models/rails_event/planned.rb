module RailsEvent::Planned
  extend ActiveSupport::Concern
  
  included do
    has_many :plans, as: :planned
  end

  def default_plan(params)
    plans.find_or_initilaze_by(
      begin_on: params[:begin_on],
      end_on: params[:end_on]
    )
  end
  
end
