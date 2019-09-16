class Event::Admin::PlanAttendersController < Event::Admin::BaseController
  before_action :set_plan_item
  before_action :set_plan_attender, only: [:edit, :update]

  def index
    @plan_participants = @plan_item.plan.plan_participants.page(params[:page])
    @bookings = @plan_item.bookings
  end

  def create
    @plan_attender = @plan_item.plan_attenders.build(event_participant_id: params[:event_participant_id])
    @plan_attender.attended = true

    unless @plan_attender.save
      render :new, locals: { model: @plan_attender }, status: :unprocessable_entity
    end
  end
  
  def edit
  end

  def update
    @plan_attender.assign_attributes(plan_attender_params)

    unless @plan_attender.save
      render :edit, locals: { model: @plan_attender }, status: :unprocessable_entity
    end
  end

  def destroy
    @plan_attender = @plan_item.plan_attenders.find_by(event_participant_id: params[:event_participant_id])
    @plan_attender.destroy
  end

  private
  def set_plan_item
    @plan_item = PlanItem.find params[:plan_item_id]
  end

  def set_plan_attender
    @plan_attender = @plan_item.plan_attenders.find(params[:id])
  end

  def plan_attender_params
    params.fetch(:plan_attender, {}).permit(
      :state,
      :attended
    )
  end

end
