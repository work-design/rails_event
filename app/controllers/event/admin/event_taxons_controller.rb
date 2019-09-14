class Event::Admin::EventTaxonsController < Event::Admin::BaseController
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

    unless @event_taxon.save
      render :new, locals: { model: @event_taxon }, status: :unprocessable_entity
    end
  end

  def show
  end

  def edit
  end

  def update
    @event_taxon.assign_attributes(event_taxon_params)

    unless @event_taxon.save
      render :edit, locals: { model: @event_taxon }, status: :unprocessable_entity
    end
  end

  def destroy
    @event_taxon.destroy
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
