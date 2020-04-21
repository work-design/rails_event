class Event::Admin::PlaceTaxonsController < Event::Admin::BaseController
  before_action :set_place_taxon, only: [:show, :edit, :update, :destroy]

  def index
    @place_taxons = PlaceTaxon.page(params[:page])
  end

  def new
    @place_taxon = PlaceTaxon.new
  end

  def create
    @place_taxon = PlaceTaxon.new(place_taxon_params)

    unless @place_taxon.save
      render :new, locals: { model: @place_taxon }, status: :unprocessable_entity
    end
  end

  def show
  end

  def edit
  end

  def update
    @place_taxon.assign_attributes(place_taxon_params)

    unless @place_taxon.save
      render :edit, locals: { model: @place_taxon }, status: :unprocessable_entity
    end
  end

  def destroy
    @place_taxon.destroy
  end

  private
  def set_place_taxon
    @place_taxon = PlaceTaxon.find(params[:id])
  end

  def place_taxon_params
    params.fetch(:place_taxon, {}).permit(
      :name,
      :position,
      :places_count
    )
  end

end
