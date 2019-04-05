class Booking::BaseController < RailsBooking.config.app_class.constantize


  private
  def repeat_settings
    return @repeat_settings if defined?(@repeat_settings)
    @repeat_settings = {
      day_count: 3,
      columnHeaderFormat: {
        weekday: 'short'
      }
    }
    if params[:repeat_type] == 'monthly'
      @repeat_settings.merge! day_count: 30, columnHeaderFormat: { day: 'numeric' }
    elsif params[:repeat_type] == 'weekly'
      @repeat_settings.merge! day_count: 7
    end
    @repeat_settings
  end

end
