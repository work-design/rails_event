class Booking::Admin::PlacesController < Booking::Admin::BaseController
  before_action :set_place, only: [:show, :edit, :update, :destroy]

  def index
    q_params = {}
    q_params.merge! default_params
    q_params.merge! params.permit(:place_number)
    @places = Place.default_where(q_params).page(params[:page])
  end

  def new
    @place = Place.new
  end

  def create
    @place = Place.new(place_params)

    respond_to do |format|
      if @place.save
        format.html.phone
        format.html { redirect_to admin_places_url }
        format.js { redirect_back fallback_location: admin_places_url }
        format.json { render :show }
      else
        format.html.phone { render :new }
        format.html { render :new }
        format.js { redirect_back fallback_location: admin_places_url }
        format.json { render :show }
      end
    end
  end

  def show
  end

  def edit
  end

  def update
    @place.assign_attributes(place_params)

    respond_to do |format|
      if @place.save
        format.html.phone
        format.html { redirect_to admin_places_url }
        format.js { redirect_back fallback_location: admin_places_url }
        format.json { render :show }
      else
        format.html.phone { render :edit }
        format.html { render :edit }
        format.js { redirect_back fallback_location: admin_places_url }
        format.json { render :show }
      end
    end
  end

  def destroy
    @place.destroy
    redirect_to admin_places_url
  end

  private
  def set_place
    @place = Place.find(params[:id])
  end

  def place_params
    p = params.fetch(:place, {}).permit(
      :place_number,
      :color,
      :limit_number
    )
    p.merge! default_form_params
  end

end
