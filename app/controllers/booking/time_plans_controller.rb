class Booking::TimePlansController < Booking::BaseController
  before_action :set_plan, :set_time_lists
  before_action :set_time_plan, only: [:show, :show_calendar, :edit, :update, :destroy]

  def index
    q_params = {}.with_indifferent_access
    q_params.merge! time_plan_params.permit(:room_id)
    @time_plans = @plan.time_plans.default_where(q_params)

    @time_plan = @plan.time_plans.find_or_initialize_by(q_params.slice(:room_id))
    @time_plan.time_list ||= @time_lists.default
    set_settings

    respond_to do |format|
      format.html
      format.js
      format.json
    end
  end

  def calendar
    @time_list = TimeList.find params[:time_list_id]
    set_settings
    @settings.merge! FullCalendarHelper.repeat_settings(repeat_type: params[:repeat_type])
    @events = @time_list.events(@settings[:defaultDate], @settings[:dayCount])
  end
  
  def new
    last_plan = @plan.time_plans.last
    @time_plan = @plan.time_plans.build
    if last_plan
      @time_plan.begin_on = last_plan.end_on + 1
    end
    @time_plan.time_list ||= @time_lists.default
  end
  
  def create
    @time_plan = @plan.time_plans.build
    @time_plan.time_list ||= @time_lists.default
    @time_plan.assign_attributes time_plan_params
    dt = params[:time_item_start].to_s.to_datetime
    @time_plan.toggle(dt, params[:time_item_id].to_i) if dt
    set_settings

    respond_to do |format|
      if @time_plan.save
        format.html.phone
        format.html { redirect_to time_plans_url(params[:plan_type], params[:plan_id]) }
        format.js
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
  end

  def show_calendar
    @time_list = TimeList.find params[:time_list_id]
    set_settings
    @settings.merge! FullCalendarHelper.repeat_settings(repeat_type: params[:repeat_type])
    @events = @time_list.events(@settings[:defaultDate], @settings[:dayCount])
    
    render :calendar
  end

  def edit
  end

  def update
    @time_plan = @plan.time_plans.find params[:id]
    @time_plan.assign_attributes time_plan_params
    dt = params[:time_item_start].to_s.to_datetime
    if dt
      diffs = @time_plan.diff_toggle(dt, params[:time_item_id].to_i)
      @time_plan.toggle(dt, params[:time_item_id].to_i)
      @remove_events = diffs[0].map do |index, time_item_id|
        "#{@time_plan.default_date + index.to_i}_#{time_item_id}"
      end
      @add_events = diffs[1].map do |index, time_item_id|
        @time_plan.item_event(time_item_id, index.to_i)
      end
    end
    set_settings

    respond_to do |format|
      if @time_plan.save
        format.html.phone
        format.html { redirect_to time_plans_url(params[:plan_type], params[:plan_id]) }
        format.js
        format.json { render :show }
      else
        format.html.phone { render :new }
        format.html { render :new }
        format.js { render :index }
        format.json { process_errors(@time_plan) }
      end
    end
  end

  def destroy
    @time_plan.destroy
    redirect_to time_plans_url(params[:plan_type], params[:plan_id])
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

  def set_settings
    @time_list ||= @time_plan.time_list
    if @time_list
      @settings = {
        minTime: @time_list.min_time,
        maxTime: @time_list.max_time,
        slotDuration: @time_list.slot_duration,
        slotLabelInterval: @time_list.slot_label_interval
      }
    else
      @settings = {
        defaultDate: '2000-01-01',
        dayCount: 7,
        minTime: '07:30:00',
        maxTime: '18:30:00',
        slotDuration: '00:10',
        slotLabelInterval: '1:00'
      }
    end
    if @time_plan
      @settings.merge!(
        defaultDate: @time_plan.default_date.to_s(:date)
      )
      repeat_settings = FullCalendarHelper.repeat_settings(repeat_type: @time_plan.repeat_type)
      @settings.merge! repeat_settings
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
