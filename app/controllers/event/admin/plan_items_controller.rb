class Event::Admin::PlanItemsController < Event::Admin::BaseController
  before_action :set_plan_item, only: [:show, :edit, :update, :qrcode, :destroy]

  def index
    q_params = {}
    filter_params = {
      start_on: Date.today.beginning_of_week,
      finish_on: Date.today.end_of_week
    }.with_indifferent_access
    filter_params.merge! params.permit(:start_on, :finish_on)
    filter_params.merge! default_params

    q_params.merge! 'end_on-gte': filter_params[:start_on], 'begin_on-lte': filter_params[:finish_on]
    q_params.merge! params.permit(:planned_type, :planned_id, :place_id, 'plan_participants.event_participant_id')

    @plans = Plan.default_where(q_params)
    @plans.each { |plan| plan.sync(start: filter_params[:start_on], finish: filter_params[:finish_on]) }

    @plan_items = PlanItem.to_events(**filter_params.symbolize_keys)
  end

  def new
    @plan_item = PlanItem.new
  end

  def create
    @plan_item = PlanItem.new(plan_item_params)

    unless @plan_item.save
      render :new, locals: { model: @plan_item }, status: :unprocessable_entity
    end
  end

  def show
  end

  def edit
    @places = Place.default_where(default_params)
  end

  def update
    @plan_item.assign_attributes(plan_item_params)

    unless @plan_item.save
      render :edit, locals: { model: @plan_item }, status: :unprocessable_entity
    end
  end
  
  def qrcode
    @plan_item.qrcode
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
      :planned_type,
      :planned_id,
      :time_item_id,
      :event_item_id,
      :place_id,
      plan_attenders_attributes: [:attender_type, :attender_id]
    )
  end

end
