class Event::Admin::EventsController < Event::Admin::BaseController
  before_action :set_event, only: [:show, :edit, :meet, :update, :destroy]

  def index
    q_params = {}
    q_params.merge! default_params
    q_params.merge! params.permit(:type, :title, :event_taxon_id, 'id-desc', 'id-asc', 'title-asc')
    @events = Event.default_where(q_params).order(id: :desc).page(params[:page])
    @event_taxons = EventTaxon.default_where(default_params)
  end

  def plan
    q_params = {}
    q_params.merge! teacher_id: current_member.id if current_member
    q_params.merge! params.permit(:type, :event_taxon_id, 'id-desc', 'id-asc', 'title-asc')
    @events = Event.default_where(q_params).page(params[:page])

    render 'index'
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)

    unless @event.save
      render :new, locals: { model: @event }, status: :unprocessable_entity
    end
  end

  def show
  end

  def edit
  end

  def update
    @event.assign_attributes(event_params)

    unless @event.save
      render :edit, locals: { model: @event }, status: :unprocessable_entity
    end
  end

  def meet

  end

  def destroy
    @event.destroy
  end

  private
  def set_event
    @event = Event.find(params[:id])
  end

  def event_params
    p = params.fetch(:event, {}).permit(
      :event_taxon_id,
      :name,
      :description,
      :type,
      :position,
      :author_id,
      :teacher_id,
      :price,
      :compulsory,
      event_items_attributes: [
        :id,
        :name,
        :_destroy,
        {
          videos: [],
          documents: [],
          videos_attachments_attributes: [:id, :_destroy],
          documents_attachments_attributes: [:id, :_destroy]
        }
      ]
    )
    p.merge! default_form_params
    p
  end

end
