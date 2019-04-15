class Booking::My::TimePlansController < Booking::My::BaseController
  before_action :set_time_lists
  before_action :set_time_plan, only: [:show]

  def index
    q_params = {}.with_indifferent_access
    q_params.merge! time_plan_params.permit(:room_id)
    @time_plans = TimePlan.default_where(q_params)
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

  def show
    q_params = {}.with_indifferent_access
    q_params.merge! params.permit(:plan_type, :plan_id)
    @time_plans = TimePlan.default_where(q_params)

    respond_to do |format|
      format.html { render :index }
      format.js { render :index }
    end
  end

  private

  def set_time_plan
    @time_plan = TimePlan.find(params[:id])
  end

  def set_time_lists
    #return super if super
    @rooms = Room.none
    @time_lists = TimeList.none
  end

  def set_settings
    @settings = {
      defaultDate: Date.today.to_s,
      dayCount: 7,
      minTime: '07:30:00',
      maxTime: '18:30:00',
      slotDuration: '00:10',
      slotLabelInterval: '1:00'
    }
  end

end
