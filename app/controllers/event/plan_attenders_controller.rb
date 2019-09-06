class Event::PlanAttendersController < Event::BaseController
  before_action :set_plan_item
  before_action :set_plan_attender, only: [:show, :edit, :update]

  def index
    @event_members = @plan_item.event.event_members.where(event_crowd_id: @plan_item.plan_id).page(params[:page])
    @time_bookings = @plan_item.time_bookings
  end

  def create
    @plan_attender = @plan_item.plan_attenders.build(event_member_id: params[:event_member_id])
    @plan_attender.attended = true
    
    respond_to do |format|
      if @plan_attender.save
        format.html.phone
        format.html { redirect_to plan_item_plan_attenders_url(@plan_item) }
        format.js { redirect_to plan_item_plan_attenders_url(@plan_item) }
        format.json { render :show }
      else
        format.html.phone { render :new }
        format.html { render :new }
        format.js { redirect_to plan_item_plan_attenders_url(@plan_item) }
        format.json { render :show }
      end
    end
  end
  
  def edit
  end

  def update
    @plan_attender.assign_attributes(plan_attender_params)

    respond_to do |format|
      if @plan_attender.save
        format.html.phone
        format.html { redirect_to plan_item_plan_attenders_url(@plan_item) }
        format.js { redirect_back fallback_location: plan_item_plan_attenders_url(@plan_item) }
        format.json { render :show }
      else
        format.html.phone { render :edit }
        format.html { render :edit }
        format.js { redirect_back fallback_location: plan_item_plan_attenders_url(@plan_item) }
        format.json { render :show }
      end
    end
  end

  def destroy
    @plan_attender = @plan_item.plan_attenders.find_by(event_member_id: params[:event_member_id])
    @plan_attender.destroy
    respond_to do |format|
      format.html { redirect_to plan_item_plan_attenders_url(@plan_item) }
      format.json { render :show }
    end
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
