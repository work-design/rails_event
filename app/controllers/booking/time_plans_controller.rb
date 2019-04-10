class Booking::TimePlansController < Booking::BaseController
  before_action :set_plan, :set_time_lists
  before_action :set_time_plan, only: [:show, :destroy]

  def index
    q_params = {}.with_indifferent_access
    q_params.merge! time_plan_params.permit(:room_id)
    @time_plans = @plan.time_plans.default_where(q_params)

    @time_plan = @plan.time_plans.find_or_initialize_by(q_params.slice(:room_id))
    @time_plan.time_list ||= @time_lists.default
    set_default_time_plan

    respond_to do |format|
      format.html
      format.js
      format.json
    end
  end

  def create
    @time_plan = @plan.time_plans.build
    @time_plan.time_list ||= @time_lists.default
    set_default_time_plan
    set_repeat_days
    @time_plan.assign_attributes time_plan_params

    respond_to do |format|
      if @time_plan.save
        format.html.phone
        format.html { redirect_to time_plans_url(params[:plan_type], params[:plan_id]), notice: 'Time plan was successfully created.' }
        format.js { render :index }
        format.json { render :show }
      else
        format.html.phone { render :new }
        format.html { render :new }
        format.js { render :index }
        format.json { process_errors(@time_plan) }
      end
    end
  end

  def update
    @time_plan = @plan.time_plans.find params[:id]
    set_default_time_plan
    set_repeat_days
    @time_plan.assign_attributes time_plan_params

    respond_to do |format|
      if @time_plan.save
        format.html.phone
        format.html { redirect_to time_plans_url(params[:plan_type], params[:plan_id]), notice: 'Time plan was successfully created.' }
        format.js { render :index }
        format.json { render :show }
      else
        format.html.phone { render :new }
        format.html { render :new }
        format.js { render :index }
        format.json { process_errors(@time_plan) }
      end
    end
  end

  def show
    q_params = {}.with_indifferent_access
    q_params.merge! params.permit(:plan_type, :plan_id)
    @time_plans = TimePlan.default_where(q_params)

    respond_to do |format|
      format.html { render :index }
      format.js { render :index }
    end
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

  def set_default_time_plan
    if @time_plan.time_list
      @settings = {
        defaultDate: @time_plan.time_list.default_date,
        minTime: @time_plan.time_list.min_time,
        maxTime: @time_plan.time_list.max_time,
        slotDuration: @time_plan.time_list.slot_duration,
        slotLabelInterval: @time_plan.time_list.slot_label_interval
      }
    else
      @settings = {
        defaultDate: '2000-01-01',
        minTime: '07:30:00',
        maxTime: '18:30:00',
        slotDuration: '00:10',
        slotLabelInterval: '1:00'
      }
    end
  end

  def set_repeat_days
    dt = params[:time_item_start].to_s.to_datetime
    if dt
      if time_plan_params[:repeat_type] == 'weekly'
        @time_plan.repeat_days.combine_merge! dt.wday => params[:time_item_id].to_i
      elsif time_plan_params[:repeat_type] == 'monthly'
        @time_plan.repeat_days.combine_merge! dt.day => params[:time_item_id].to_i
      elsif time_plan_params[:repeat_type] == 'once'
        @time_plan.repeat_days.combine_merge! dt.to_s(:date) => params[:time_item_id].to_i
      end
    end
  end

  def time_plan_params
    p = params.fetch(:time_plan, {}).permit(
      :time_list_id,
      :room_id,
      :begin_on,
      :end_on,
      :repeat_type,
      repeat_days: [],
      time_items_ids: []
    )
    p.merge! plan_params
  end

end
