class Booking::PlanAttendersController < Booking::BaseController
  before_action :set_plan_item
  before_action :set_plan_attender, only: [:show, :edit, :update]

  def index
    @course_students = @plan_item.course.course_students.page(params[:page])
  end

  def create
    @plan_attender = @plan_item.plan_attenders.build(course_student_id: params[:course_student_id])

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
    @plan_attender = @plan_item.plan_attenders.find_by(course_student_id: params[:course_student_id])
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
