class Event::Admin::TimeListsController < Event::Admin::BaseController
  before_action :set_time_list, only: [:show, :edit, :update, :destroy]

  def index
    q_params = {}
    q_params.merge! default_params
    @time_lists = TimeList.default_where(q_params).order(id: :asc).page(params[:page])
  end

  def new
    @time_list = TimeList.new
  end

  def create
    @time_list = TimeList.new(time_list_params)

    unless @time_list.save
      render :new, locals: { model: @time_list }, status: :unprocessable_entity
    end
  end

  def show
  end

  def edit
  end

  def update
    @time_list.assign_attributes(time_list_params)

    unless @time_list.save
      render :edit, locals: { model: @time_list }, status: :unprocessable_entity
    end
  end

  def destroy
    @time_list.destroy
  end

  private
  def set_time_list
    @time_list = TimeList.find(params[:id])
  end

  def time_list_params
    p = params.fetch(:time_list, {}).permit(
      :name,
      :code,
      :interval_minutes,
      :item_minutes,
      :default,
      time_items_attributes: [
        :id,
        :start_at,
        :finish_at,
        :_destroy
      ]
    )
    p.merge! default_form_params
  end

end
