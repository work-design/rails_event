class Event::Admin::EventParticipantsController < Event::Admin::BaseController
  before_action :set_event
  before_action :set_event_participant, only: [:show, :edit, :update]

  def index
    q_params = {}
    q_params.merge! params.permit(:id, :state)
    @event_participants = @event.event_participants.default_where(q_params).page(params[:page])
  end

  def new
    @event_participant = EventParticipant.new
  end

  def create
    @event_participant = @event.event_participants.build(event_participant_params)

    unless @event_participant.save
      render :new, locals: { model: @event_participant }, status: :unprocessable_entity
    end
  end

  def update
    @event_participant.assign_attributes(event_participant_params)

    unless @event_participant.save
      render :edit, locals: { model: @event_participant }, status: :unprocessable_entity
    end
  end

  def destroy
    @event_participant = @event.event_participants.find_by(crowd_member_id: params[:crowd_member_id])
    @event_participant.destroy
  end

  def check
    add_ids = params[:add_ids].split(',')
    if add_ids.present?
      members = Member.where(id: add_ids)
      members.each do |member|
        add = @event.event_participants.find_or_initialize_by(member_id: member.id)
        add.save_with_remind
      end
    end

    remove_ids = params[:remove_ids].split(',')
    if remove_ids.present?
      @event.event_participants.where(member_id: remove_ids).each do |pl|
        pl.destroy
      end
    end

    redirect_to admin_event_event_participants_url(@event)
  end

  def attend
    if params[:add_ids].present?
      adds = EventParticipant.where(id: params[:add_ids].split(','))
      adds.update_all attended: true
    end

    if params[:remove_ids].present?
      removes = EventParticipant.where(id: params[:remove_ids].split(','))
      removes.update_all attended: false
    end

    head :no_content
  end

  def show
    @event_participant = EventParticipant.find_by(id: params[:id])
    @eduing_histories = @event_participant.eduing_histories.order('id desc')
  end

  def edit
    @title = "Assign Events"
  end

  def quit
    @event_participant = EventParticipant.find params[:id]
    @event_participant.trigger_to! state: 'quitted'
    redirect_to admin_event_event_participants_url(member_id: @event_participant.member_id)
  end

  private
  def set_event
    @event = Event.find params[:event_id]
  end

  def set_event_participant
    @event_participant = EventParticipant.find(params[:id])
  end

  def event_participant_params
    p = params.fetch(:event_participant, {}).permit(
      :state
    )
    p.merge! params.permit(:member_type, :member_id, :crowd_member_id, :event_crowd_id)
  end

end
