class Event::Admin::PlansController < Event::Admin::BaseController
  before_action :set_time_lists
  before_action :set_plan, only: [:show, :show_calendar, :edit, :update, :destroy]

  def index
    q_params = {}
    item_params = {}
    filter_params = {
      start_on: Date.today.beginning_of_week,
      finish_on: Date.today.end_of_week
    }
    filter_params.merge! params.permit(:start_on, :finish_on)
    
    q_params.merge! 'end_on-gte': filter_params[:start_on], 'begin_on-lte': filter_params[:finish_on]
    q_params.merge! params.permit(:planned_type, :planned_id, :place_id, 'plan_participants.event_participant_id')
    
    item_params.merge! 'plan_on-gte': filter_params[:start_on], 'plan_on-lte': filter_params[:finish_on]
    @plans = Plan.default_where(q_params)
    @plans.each { |plan| plan.sync(start: filter_params[:start_on], finish: filter_params[:finish_on]) }
    @plan_items = PlanItem.default_where(item_params).group_by(&->(i){i.plan_on})
    
    r = (filter_params[:start_on].to_date .. filter_params[:finish_on].to_date).map { |i| [i, []] }.to_h
    @plan_items.reverse_merge! r
  end

  def calendar
    @time_list = TimeList.find params[:time_list_id]
    set_settings
    @settings.merge! FullCalendarHelper.repeat_settings(repeat_type: params[:repeat_type])
    @events = @time_list.events(@settings[:defaultDate], @settings[:dayCount])
  end
  
  def new
    @plan = Plan.new
  end
  
  def create
    @plan = Plan.new
    @plan.time_list ||= @time_lists.default
    @plan.assign_attributes plan_params
    
    #dt = params[:index].to_s
    #@plan.toggle(dt, params[:time_item_id].to_i) if dt

    respond_to do |format|
      if @plan.save
        format.html.phone
        format.html { redirect_to plans_url(params[:plan_type], params[:plan_id]) }
        format.js
        format.json { render :show }
      else
        format.html.phone { render :new }
        format.html { render :new }
        format.js { render :index }
        format.json { process_errors(@plan) }
      end
    end
  end

  def show
    q_params = {}
    @plans = @plan.plans.default_where(q_params)
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
    @plan = @plan.plans.find params[:id]
    @plan.assign_attributes plan_params
    dt = params[:index].to_s
    if dt
      @plan.toggle(dt, params[:time_item_id].to_i)
    end

    respond_to do |format|
      if @plan.save
        format.html.phone
        format.html { redirect_to plans_url(params[:plan_type], params[:plan_id]) }
        format.js { redirect_to plan_url(@plan.plan_type, @plan.plan_id, @plan) }
        format.json { render :show }
      else
        format.html.phone { render :new }
        format.html { render :new }
        format.js { render :index }
        format.json { process_errors(@plan) }
      end
    end
  end

  def destroy
    @plan.destroy
    redirect_to plans_url(params[:plan_type], params[:plan_id])
  end

  private
  def set_plan
    @plan = Plan.find(params[:id])
  end

  def set_time_lists
    q_params = {}
    q_params.merge! default_params
    @places = Place.default_where(q_params)
    @time_lists = TimeList.default_where(q_params)
    @time_list = @time_lists.default
  end

  def set_settings
    @time_list ||= @plan.time_list
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
    if @plan
      @settings.merge!(
        defaultDate: @plan.default_date.to_s(:date)
      )
      repeat_settings = FullCalendarHelper.repeat_settings(repeat_type: @plan.repeat_type)
      @settings.merge! repeat_settings
    end
  end

  def plan_params
    p = params.fetch(:plan, {}).permit(
      :planned_type,
      :planned_id,
      :time_list_id,
      :place_id,
      :begin_on,
      :end_on,
      :repeat_type,
      repeat_days: {},
      plan_participants_attributes: {}
    )
    unless p[:planned_type] || p[:planned_id]
      p.merge! params.permit(:planned_type, :planned_id)
    end
    p
  end

end
