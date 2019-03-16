class Booking::TimeItemsController < Booking::BaseController
  before_action :set_time_list

  def index
    @time_items = @time_list.time_items.page(params[:page])
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
