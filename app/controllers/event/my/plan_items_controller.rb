class Event::My::PlanItemsController < Event::My::BaseController
  before_action :set_plan_item, only: [:show, :edit, :update, :destroy]

  def index
    q_params = {
      'plan_on-gte': Date.today,
      'plan_participants.participant_id': current_member.id
    }
    q_params.merge! 'plan_on-gte': params[:start_date] if params[:start_date]
    q_params.merge! 'plan_on-lte': params[:end_date] if params[:end_date]
    q_params.merge! params.permit(:place_id)

    @plan_items = PlanItem.includes(:place, :time_item).default_where(q_params).order(plan_on: :asc).page(params[:page]).per(params[:per])
  end

  def plan
    set_time_lists
    q_params = {}
    q_params.merge! params.permit(:place_id)
    @time_plans = @event_crowd.time_plans.default_where(q_params)

    @plan = @event_crowd.time_plans.find_or_initialize_by(q_params.slice(:place_id))
    @plan.time_list ||= TimeList.default
  end

  def show
  end

  def edit
  end

  def update
    @plan_item.assign_attributes(plan_item_params)

    unless @plan_item.save
      render :edit, locals: { model: @plan_item }, status: :unprocessable_entity
    end
  end

  def destroy
    @plan_item.destroy
  end

  private
  def set_plan_item
    @plan_item = PlanItem.find(params[:id])
  end

  def plan_item_params
    params.fetch(:plan_item, {}).permit(
      :event_item_id,
      :place_id
    )
  end

end
