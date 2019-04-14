class Booking::TimeBookingsController < Booking::BaseController
  before_action :set_time_booking, only: [:show, :edit, :update, :destroy]

  def index
    q_params = {
    }
    q_params.merge! params.permit(:booked_type, :booked_id)
    @time_bookings = TimeBooking.default_where(q_params).page(params[:page])
  end

  def new
    @time_booking = TimeBooking.new
  end

  def create
    @time_booking = TimeBooking.new(time_booking_params)

    respond_to do |format|
      if @time_booking.save
        format.html.phone
        format.html { redirect_to booking_time_bookings_url, notice: 'Time booking was successfully created.' }
        format.js { redirect_back fallback_location: booking_time_bookings_url }
        format.json { render :show }
      else
        format.html.phone { render :new }
        format.html { render :new }
        format.js { redirect_back fallback_location: booking_time_bookings_url }
        format.json { render :show }
      end
    end
  end

  def show
  end

  def edit
  end

  def update
    @time_booking.assign_attributes(time_booking_params)

    respond_to do |format|
      if @time_booking.save
        format.html.phone
        format.html { redirect_to booking_time_bookings_url, notice: 'Time booking was successfully updated.' }
        format.js { redirect_back fallback_location: booking_time_bookings_url }
        format.json { render :show }
      else
        format.html.phone { render :edit }
        format.html { render :edit }
        format.js { redirect_back fallback_location: booking_time_bookings_url }
        format.json { render :show }
      end
    end
  end

  def destroy
    @time_booking.destroy
    redirect_to booking_time_bookings_url, notice: 'Time booking was successfully destroyed.'
  end

  private
  def set_time_booking
    @time_booking = TimeBooking.find(params[:id])
  end

  def booking_params
    params.permit(:booked_type, :booked_id)
  end

  def time_booking_params
    p = params.fetch(:time_booking, {}).permit(
      :time_list_id,
      :time_item_id,
      :room_id,
      :booking_on
    )
    p.merge! booking_params
  end

end
