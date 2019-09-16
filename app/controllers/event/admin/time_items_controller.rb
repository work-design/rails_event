class Event::Admin::TimeItemsController < Event::Admin::BaseController
  before_action :set_time_list, except: [:default]
  before_action :set_time_item, only: [:show, :edit, :update, :destroy]

  def index
    @time_items = @time_list.time_items.page(params[:page])
  end
  
  def default
    q_params = {}
    q_params.merge! default_params
    time_list = TimeList.default_where(q_params).default
    if time_list
      @time_items = time_list.time_items
    else
      @time_items = TimeItem.none
    end
  end

  def select
    @time_items = @time_list.time_items
  
    if @time_items
      @results = @time_items.map { |x| { value: x.id, text: x.name, name: x.name } }
    end
  
    respond_to do |format|
      format.js
      format.json { render json: { values: @results } }
    end
  end

  def new
    @time_item = @time_list.time_items.build
  end

  def create
    @time_item = @time_list.time_items.build(time_item_params)

    unless @time_item.save
      render :new, locals: { model: @time_item }, status: :unprocessable_entity
    end
  end

  def show
  end

  def edit
  end

  def update
    @time_item.assign_attributes(time_item_params)

    unless @time_item.save
      render :edit, locals: { model: @time_item }, status: :unprocessable_entity
    end
  end

  def destroy
    @time_item.destroy
  end

  private
  def set_time_list
    @time_list = TimeList.find params[:time_list_id]
  end

  def set_time_item
    @time_item = TimeItem.find(params[:id])
  end

  def time_item_params
    params.fetch(:time_item, {}).permit(
      :start_at,
      :finish_at,
      :position
    )
  end

end
