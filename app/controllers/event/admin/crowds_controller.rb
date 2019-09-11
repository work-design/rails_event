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

    respond_to do |format|
      if @crowd.save
        format.html.phone
        format.html { redirect_to admin_crowds_url }
        format.js { redirect_back fallback_location: admin_crowds_url }
        format.json { render :show }
      else
        format.html.phone { render :new }
        format.html { render :new }
        format.js { redirect_back fallback_location: admin_crowds_url }
        format.json { render :show }
      end
    end
  end

  def show
    @crowd_members = @crowd.crowd_members.includes(:member)
  end

  def edit
  end

  def update
    @crowd.assign_attributes(crowd_params)

    respond_to do |format|
      if @crowd.save
        format.html.phone
        format.html { redirect_to admin_crowds_url }
        format.js { redirect_back fallback_location: admin_crowds_url }
        format.json { render :show }
      else
        format.html.phone { render :edit }
        format.html { render :edit }
        format.js { redirect_back fallback_location: admin_crowds_url }
        format.json { render :show }
      end
    end
  end

  def destroy
    @crowd.destroy
    
    respond_to do |format|
      format.html { redirect_to admin_crowds_url }
      format.json { head :no_content }
    end
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
