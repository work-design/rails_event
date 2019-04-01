class Booking::TimePlansController < Booking::BaseController
  before_action :set_time_lists
  before_action :set_time_plan, only: [:show, :destroy]

  def index
    q_params = {}.with_indifferent_access
    q_params.merge! params.permit(:plan_type, :plan_id)
    @time_plans = TimePlan.default_where(q_params)
    @time_plan = TimePlan.new(plan_params)
  end

  def create
    @time_plan = TimePlan.new(time_plan_params)

    respond_to do |format|
      if @time_plan.save
        format.html.phone
        format.html { redirect_to time_plans_url(params[:plan_type], params[:plan_id]), notice: 'Time plan was successfully created.' }
        format.js { redirect_back fallback_location: time_plans_url(params[:plan_type], params[:plan_id]) }
        format.json { render :show }
      else
        format.html.phone { render :new }
        format.html { render :new }
        format.js { redirect_back fallback_location: time_plans_url(params[:plan_type], params[:plan_id]) }
        format.json { render :show }
      end
    end
  end

  def show
  end

  def destroy
    @time_plan.destroy
    redirect_to time_plans_url(params[:plan_type], params[:plan_id]), notice: 'Time plan was successfully destroyed.'
  end

  private
  def set_plan
    @plan = params[:plan_type].constantize.find params[:plan_id]
  end

  def set_time_plan
    @time_plan = TimePlan.find(params[:id])
  end

  def set_time_lists
    return super if super
    @rooms = Room.none
    @time_lists = TimeList.none
  end

  def plan_params
    params.permit(:plan_type, :plan_id)
  end

  def time_plan_params
    p = params.fetch(:time_plan, {}).permit(
      :time_list_id,
      :time_item_id,
      :room_id,
      :repeat_type,
      repeat_days: []
    )
    p.merge! plan_params
  end

end
