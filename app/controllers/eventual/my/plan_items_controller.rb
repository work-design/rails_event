module Eventual
  class My::PlanItemsController < My::BaseController
    before_action :set_time_lists
    before_action :set_time_plan, only: [:show]

    def index
      q_params = {}
      q_params.merge! params.permit(:place_id)

      @time_plans = TimePlan.default_where(q_params)
      @events = @time_plans.map do |plan|
        plan
      end.flatten
    end

    def calendar
      @time_list = TimeList.find params[:time_list_id]
      @events = @time_list.events(@settings[:defaultDate], @settings[:dayCount])
    end

    def show
      q_params = {}
      q_params.merge! params.permit(:plan_type, :plan_id)
      @time_plans = TimePlan.default_where(q_params)

      respond_to do |format|
        format.html { render :index }
        format.js { render :index }
      end
    end

    private
    def set_time_plan
      @plan = TimePlan.find(params[:id])
    end

    def set_time_lists
      #return super if super
      @places = Place.none
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
end
