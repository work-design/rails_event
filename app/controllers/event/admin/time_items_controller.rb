class Booking::Admin::TimeItemsController < Booking::Admin::BaseController
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

  def new
    @time_item = @time_list.time_items.build
  end

  def create
    @time_item = @time_list.time_items.build(time_item_params)

    respond_to do |format|
      if @time_item.save
        format.html.phone
        format.html { redirect_to admin_time_list_time_items_url(@time_list) }
        format.js { redirect_to admin_time_lists_url(id: @time_list) }
        format.json { render :show }
      else
        format.html.phone { render :new }
        format.html { render :new }
        format.js { redirect_back fallback_location: admin_time_list_time_items_url(@time_list) }
        format.json { render :show }
      end
    end
  end

  def show
  end

  def edit
  end

  def update
    @time_item.assign_attributes(time_item_params)

    respond_to do |format|
      if @time_item.save
        format.html.phone
        format.html { redirect_to admin_time_list_time_items_url(@time_list) }
        format.js { redirect_back fallback_location: admin_time_list_time_items_url(@time_list) }
        format.json { render :show }
      else
        format.html.phone { render :edit }
        format.html { render :edit }
        format.js { redirect_back fallback_location: admin_time_list_time_items_url(@time_list) }
        format.json { render :show }
      end
    end
  end

  def destroy
    @time_item.destroy
    redirect_to admin_time_lists_url
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
