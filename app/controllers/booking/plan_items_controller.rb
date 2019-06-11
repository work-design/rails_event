class Booking::PlanItemsController < Booking::BaseController
  before_action :set_plan
  before_action :set_plan_item, only: [:show, :edit, :update, :qrcode, :destroy]

  def index
    q_params = {
      'booking_on-gte': Date.today
    }
    q_params.merge! params.permit('booking_on-gte', 'booking_on-lte')
    @plan.sync(start: q_params['booking_on-gte'], finish: q_params['booking_on-lte']) if q_params['booking_on-gte'] && q_params['booking_on-lte']
    @plan_items = @plan.plan_items.includes(:wechat_response).default_where(q_params).order(booking_on: :asc).page(params[:page])
  end

  def plan
    set_time_lists
    q_params = {}
    q_params.merge! params.permit(:room_id)
    @time_plans = @plan.time_plans.default_where(q_params)

    @time_plan = @plan.time_plans.recent || @plan.time_plans.build
    @time_plan.time_list ||= TimeList.default
  end

  def new
    @plan_item = @plan.plan_items.build
  end

  def create
    @plan_item = @plan.plan_items.build(course_plan_params)

    respond_to do |format|
      if @plan_item.save
        format.html.phone
        format.html { redirect_to admin_course_crowd_plans_url(@plan) }
        format.js { redirect_back fallback_location: admin_course_crowd_plans_url(@plan) }
        format.json { render :show }
      else
        format.html.phone { render :new }
        format.html { render :new }
        format.js { redirect_back fallback_location: admin_course_crowd_plans_url(@plan) }
        format.json { render :show }
      end
    end
  end

  def show
  end

  def edit
    @rooms = Room.default_where(default_params)
  end

  def update
    @plan_item.assign_attributes(course_plan_params)

    respond_to do |format|
      if @plan_item.save
        format.html.phone
        format.html { redirect_to admin_course_crowd_plans_url(@plan) }
        format.js { redirect_back fallback_location: admin_course_crowd_plans_url(@plan) }
        format.json { render :show }
      else
        format.html.phone { render :edit }
        format.html { render :edit }
        format.js { redirect_back fallback_location: admin_course_crowd_plans_url(@plan) }
        format.json { render :show }
      end
    end
  end
  
  def qrcode
    wechat_config = current_organ.wechat_configs.first
    unless @plan_item.wechat_response
      @plan_item.create_wechat_response(type: 'TempScanResponse', valid_response: '签到成功', wechat_config_id: wechat_config.id) if wechat_config
    end
    redirect_to admin_course_crowd_plans_url(@plan)
  end

  def destroy
    @plan_item.destroy
    redirect_to admin_course_crowd_plans_url(@plan)
  end

  private
  def set_plan
    @plan = params[:plan_type].constantize.find params[:plan_id]
  end

  def set_course_plan
    @plan_item = PlanItem.find(params[:id])
  end

  def course_plan_params
    params.fetch(:plan_item, {}).permit(
      :lesson_id,
      :room_id,
      :teacher_id
    )
  end

end
