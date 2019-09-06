class Edu::Admin::EventTaxonsController < Edu::Admin::BaseController
  before_action :set_event_taxon, only: [:show, :edit, :update, :destroy]

  def index
    q_params = {}
    q_params.merge! default_params
    @event_taxons = EventTaxon.default_where(q_params).order(id: :asc).page(params[:page])
  end

  def new
    @event_taxon = EventTaxon.new
  end

  def create
    @event_taxon = EventTaxon.new(event_taxon_params)
    
    respond_to do |format|
      if @event_taxon.save
        format.html { redirect_to admin_event_taxons_url }
        format.js
      else
        format.html { render :new }
        format.js
      end
    end
  end

  def show
  end

  def edit
  end

  def update
    if @event_taxon.update(event_taxon_params)
      redirect_to admin_event_taxons_url
    else
      render :edit
    end
  end

  def destroy
    @event_taxon.destroy
    redirect_to admin_event_taxons_url
  end

  private
  def set_event_taxon
    @event_taxon = EventTaxon.find(params[:id])
  end

  def event_taxon_params
    p = params.fetch(:event_taxon, {}).permit(
      :name
    )
    p.merge! default_form_params
  end

end
