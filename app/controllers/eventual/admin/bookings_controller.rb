module Eventual
  class Admin::BookingsController < Admin::BaseController
    before_action :set_plan_item

    def index
      q_params = {
      }
      q_params.merge! params.permit(:booker_type, :booker_id)
      @bookings = @plan_item.bookings.default_where(q_params).page(params[:page])
    end

    def new
      @booking = @plan_item.bookings.build
    end

    def create
      @booking = @plan_item.bookings.find_or_initialize_by(booker_type: params[:booker_type], booker_id: params[:booker_id])

      unless @booking.save
        render :new, locals: { model: @booking }, status: :unprocessable_entity
      end
    end

    def destroy
      if params[:id]
        @booking = @plan_item.bookings.find(params[:id])
      elsif params[:booker_type] && params[:booker_id]
        @booking = @plan_item.bookings.find_by(booker_type: params[:booker_type], booker_id: params[:booker_id])
      end

      @booking.destroy if @booking
    end

    private
    def set_plan_item
      @plan_item = PlanItem.find params[:plan_item_id]
    end

    def set_booking
    end

  end
end
