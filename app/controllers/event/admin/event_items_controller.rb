class Edu::Admin::EventItemsController < Edu::Admin::BaseController
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

    respond_to do |format|
      if @event_item.save
        format.html.phone
        format.html { redirect_to admin_event_items_url }
        format.js { redirect_to admin_event_event_items_url(@event) }
        format.json { render :show }
      else
        format.html.phone { render :new }
        format.html { render :new }
        format.js
        format.json { render :show }
      end
    end
  end

  def show
  end

  def edit
  end

  def update
    @event_item.assign_attributes(event_item_params)

    respond_to do |format|
      if @event_item.save
        format.html.phone
        format.html { redirect_to admin_event_event_items_url(@event) }
        format.js { redirect_to admin_event_event_items_url(@event) }
        format.json { render :show }
      else
        format.html.phone { render :edit }
        format.html { render :edit }
        format.js
        format.json { render :show }
      end
    end
  end

  def destroy
    @event_item.destroy
    redirect_to admin_event_items_url
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
      :title,
      videos: [],
      documents: []
    )
  end

end
