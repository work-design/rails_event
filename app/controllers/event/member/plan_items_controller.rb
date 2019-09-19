class Event::Member::PlanItemsController < Event::Member::BaseController
  #before_action :set_event_plan, only: [:show, :edit, :update, :destroy]

  def index
    q_params = {
      'plan_on-gte': Date.today,
      'plan_participants.participant_id': current_member.id
    }
    q_params.merge! 'plan_on-gte': params[:start_date] if params[:start_date]
    q_params.merge! 'plan_on-lte': params[:end_date] if params[:end_date]
    q_params.merge! params.permit(:place_id)

    @plan_items = PlanItem.includes(:place, :event, :time_item).default_where(q_params).order(plan_on: :asc).page(params[:page]).per(params[:per])
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
    @event_plan.assign_attributes(event_plan_params)

    respond_to do |format|
      if @event_plan.save
        format.html.phone
        format.html { redirect_to admin_event_crowd_plans_url(@event_crowd) }
        format.js { redirect_back fallback_location: admin_event_crowd_plans_url(@event_crowd) }
        format.json { render :show }
      else
        format.html.phone { render :edit }
        format.html { render :edit }
        format.js { redirect_back fallback_location: admin_event_crowd_plans_url(@event_crowd) }
        format.json { render :show }
      end
    end
  end

  def destroy
    @event_plan.destroy
    redirect_to admin_event_crowd_plans_url(@event_crowd)
  end

  private
  def set_event_plan
    @event_plan = PlanItem.find(params[:id])
  end

  def event_plan_params
    params.fetch(:event_plan, {}).permit(
      :event_item_id,
      :place_id
    )
  end

end
