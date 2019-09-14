class Event::Admin::CrowdsController < Event::Admin::BaseController
  before_action :set_crowd, only: [:show, :edit, :update, :destroy]

  def index
    q_params = default_params
    q_params.merge! params.permit(:name)
    @crowds = Crowd.default_where(q_params).page(params[:page])
  end

  def new
    @crowd = Crowd.new
  end

  def create
    @crowd = Crowd.new(crowd_params)

    unless @crowd.save
      render :new, locals: { model: @crowd }, status: :unprocessable_entity
    end
  end

  def show
    @crowd_members = @crowd.crowd_members.includes(:member)
  end

  def edit
  end

  def update
    @crowd.assign_attributes(crowd_params)

    unless @crowd.save
      render :edit, locals: { model: @crowd }, status: :unprocessable_entity
    end
  end

  def destroy
    @crowd.destroy
  end

  private
  def set_crowd
    @crowd = Crowd.find(params[:id])
  end

  def crowd_params
    p = params.fetch(:crowd, {}).permit(
      :name,
      :logo,
      :member_type
    )
    p.merge! default_form_params
  end

end
