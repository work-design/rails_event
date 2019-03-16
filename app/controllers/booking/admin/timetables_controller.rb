class Booking::Admin::TimetablesController < Booking::Admin::BaseController
  before_action :set_timetable, only: [:show, :edit, :update, :destroy]

  def index
    @timetables = Timetable.page(params[:page])
  end

  def new
    @timetable = Timetable.new
  end

  def create
    @timetable = Timetable.new(timetable_params)

    respond_to do |format|
      if @timetable.save
        format.html.phone
        format.html { redirect_to admin_timetables_url, notice: 'Timetable was successfully created.' }
        format.js
        format.json { render :show }
      else
        format.html.phone { render :new }
        format.html { render :new }
        format.js
        format.json { render :show }
      end
    end
  end

  def show
  end

  def edit
  end

  def update
    @timetable.assign_attributes(timetable_params)

    respond_to do |format|
      if @timetable.save
        format.html.phone
        format.html { redirect_to admin_timetables_url, notice: 'Timetable was successfully updated.' }
        format.js { redirect_back fallback_location: admin_timetables_url }
        format.json { render :show }
      else
        format.html.phone { render :edit }
        format.html { render :edit }
        format.js
        format.json { render :show }
      end
    end
  end

  def destroy
    @timetable.destroy
    redirect_to admin_timetables_url, notice: 'Timetable was successfully destroyed.'
  end

  private
  def set_timetable
    @timetable = Timetable.find(params[:id])
  end

  def timetable_params
    params.fetch(:timetable, {}).permit(
      :kind,
      :start_at,
      :finish_at
    )
  end

end
