class Edu::Admin::EventMembersController < Edu::Admin::BaseController
  before_action :set_event
  before_action :set_event_member, only: [:show, :edit, :update]

  def index
    q_params = {}
    q_params.merge! params.permit(:id, :state)
    @event_members = @event.event_members.default_where(q_params).page(params[:page])
  end

  def new
    @event_member = EventMember.new
  end

  def create
    @event_member = @event.event_members.build(event_member_params)

    if @event_member.save
      redirect_to admin_event_event_crowds_url(@event)
    else
      render :new
    end
  end

  def update
    if @event_member.update(event_member_params)
      redirect_to event_members_url
    else
      render :edit
    end
  end

  def destroy
    @event_member = @event.event_members.find_by(crowd_member_id: params[:crowd_member_id])
    @event_member.destroy

    redirect_to admin_event_event_crowds_url(@event)
  end

  def check
    add_ids = params[:add_ids].split(',')
    if add_ids.present?
      members = Member.where(id: add_ids)
      members.each do |member|
        add = @event.event_members.find_or_initialize_by(member_id: member.id)
        add.save_with_remind
      end
    end

    remove_ids = params[:remove_ids].split(',')
    if remove_ids.present?
      @event.event_members.where(member_id: remove_ids).each do |pl|
        pl.destroy
      end
    end

    redirect_to admin_event_event_members_url(@event)
  end

  def attend
    if params[:add_ids].present?
      adds = EventMember.where(id: params[:add_ids].split(','))
      adds.update_all attended: true
    end

    if params[:remove_ids].present?
      removes = EventMember.where(id: params[:remove_ids].split(','))
      removes.update_all attended: false
    end

    head :no_content
  end

  def show
    @event_member = EventMember.find_by(id: params[:id])
    @eduing_histories = @event_member.eduing_histories.order('id desc')
  end

  def edit
    @title = "Assign Events"
  end

  def quit
    @event_member = EventMember.find params[:id]
    @event_member.trigger_to! state: 'quitted'
    redirect_to admin_event_event_members_url(member_id: @event_member.member_id)
  end

  private
  def set_event
    @event = Event.find params[:event_id]
  end

  def set_event_member
    @event_member = EventMember.find(params[:id])
  end

  def event_member_params
    p = params.fetch(:event_member, {}).permit(
      :state
    )
    p.merge! params.permit(:member_type, :member_id, :crowd_member_id, :event_crowd_id)
  end

end
