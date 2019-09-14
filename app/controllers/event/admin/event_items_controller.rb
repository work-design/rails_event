class Event::Admin::EventItemsController < Event::Admin::BaseController
  before_action :set_event
  before_action :set_event_item, only: [:show, :edit, :update, :destroy]

  def index
    @event_items = @event.event_items.page(params[:page])
  end

  def new
    @event_item = @event.event_items.build
  end

  def create
    @event_item = @event.event_items.build(event_item_params)

    unless @event_item.save
      render :new, locals: { model: @event_item }, status: :unprocessable_entity
    end
  end

  def show
  end

  def edit
  end

  def update
    @event_item.assign_attributes(event_item_params)

    unless @event_item.save
      render :edit, locals: { model: @event_item }, status: :unprocessable_entity
    end
  end

  def destroy
    @event_item.destroy
  end

  private
  def set_event
    @event = Event.find params[:event_id]
  end

  def set_event_item
    @event_item = EventItem.find(params[:id])
  end

  def event_item_params
    params.fetch(:event_item, {}).permit(
      :name,
      videos: [],
      documents: []
    )
  end

end
