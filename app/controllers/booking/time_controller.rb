class Booking::TimeController < Booking::BaseController
  skip_before_action :verify_authenticity_token, only: [:repeat_form]

  def repeat_form
    @booking = params[:booking_type].classify.constantize.new
    @booking.repeat_type = params[:repeat_type]
    if @booking.repeat_type_changed?
      @booking.repeat_days = []
    end
  end

  def calendar
    @settings = {
      dayCount: repeat_settings[:day_count],
      columnHeaderFormat: repeat_settings[:columnHeaderFormat].to_json
    }
  end


end
