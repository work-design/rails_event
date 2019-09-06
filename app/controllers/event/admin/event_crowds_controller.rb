class Event::Admin::EventCrowdsController < Event::Admin::BaseController
  before_action :set_event
  before_action :set_event_crowds
  before_action :set_event_crowd, only: [:edit, :update, :destroy]

  def index
    q_params = default_params.merge! params.permit(:id, :name, :email, :department_id)
    @event_crowds = @event.event_crowds.default_where(q_params).order(id: :asc).includes(crowd: :members)
  end

  def new
    @event_crowd = @event.event_crowds.build
    @crowds = Crowd.default_where(default_params).where.not(id: @event.crowd_ids)
    @rooms = Room.default_where(default_params)
  end

  def create
    @event_crowd = @event.event_crowds.find_or_initialize_by(crowd_id: event_crowd_params[:crowd_id])
    @event_crowd.room_id = event_crowd_params[:room_id]
    
    respond_to do |format|
      if @event_crowd.save
        format.html.phone
        format.html { redirect_to admin_event_event_crowds_url(@event) }
        format.js { redirect_to admin_event_event_crowds_url(@event) }
        format.json { render :show }
      else
        format.html.phone { render :new }
        format.html { render :new }
        format.js { redirect_to admin_event_event_crowds_url(@event) }
        format.json { render :show }
      end
    end
  end

  def edit
    @rooms = Room.default_where(default_params)
  end

  def update
    @event_crowd.assign_attributes(event_crowd_params)

    respond_to do |format|
      if @event_crowd.save
        format.html.phone
        format.html { redirect_to admin_event_event_crowds_url(@event) }
        format.js { redirect_back fallback_location: admin_event_event_crowds_url(@event) }
        format.json { render :show }
      else
        format.html.phone { render :edit }
        format.html { render :edit }
        format.js { redirect_back fallback_location: admin_event_event_crowds_url(@event) }
        format.json { render :show }
      end
    end
  end

  def destroy
    @event_crowd.destroy

    redirect_to admin_event_event_crowds_url(@event)
  end

  private
  def set_event_crowds
    q_params = {}.with_indifferent_access
    q_params.merge! params.permit(:id, :email, :name, :office_id, :email)
    @event_crowds = @event.event_crowds
    @crowds = Crowd.includes(crowd_members: :member).default_where(q_params).page(params[:page])

    @event_members = @event.event_members.page(params[:page])
  end

  def set_event
    @event = Event.find(params[:event_id])
  end

  def set_event_crowd
    @event_crowd = @event.event_crowds.find params[:id]
  end

  def event_crowd_params
    params.fetch(:event_crowd, {}).permit(
      :crowd_id,
      :teacher_id,
      :room_id
    )
  end

end
