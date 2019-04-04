class Booking::BaseController < RailsBooking.config.app_class.constantize


  private
  def day_count
    if params[:repeat_type] == 'monthly'
      30
    elsif params[:repeat_type] == 'weekly'
      7
    else
      3
    end
  end

end
