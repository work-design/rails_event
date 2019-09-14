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

    unless @event_crowd.save
      render :new, locals: { model: @event_crowd }, status: :unprocessable_entity
    end
  end

  def edit
    @rooms = Room.default_where(default_params)
  end

  def update
    @event_crowd.assign_attributes(event_crowd_params)

    unless @crowd.save
      render :edit, locals: { model: @crowd }, status: :unprocessable_entity
    end
  end

  def destroy
    @event_crowd.destroy
  end

  private
  def set_event_crowds
    q_params = {}.with_indifferent_access
    q_params.merge! params.permit(:id, :email, :name, :office_id, :email)
    @event_crowds = @event.event_crowds
    @crowds = Crowd.includes(crowd_members: :member).default_where(q_params).page(params[:page])

    @event_participants = @event.event_participants.page(params[:page])
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
