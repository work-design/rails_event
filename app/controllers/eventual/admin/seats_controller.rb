module Eventual
  class Admin::SeatsController < Admin::BaseController
    before_action :set_place
    before_action :set_seat, only: [:show, :edit, :update, :destroy]

    def index
      @seats = @place.seats.page(params[:page])
    end

    def new
      @seat = @place.seats.build
    end

    def create
      @seat = @place.seats.build(seat_params)

      unless @seat.save
        render :new, locals: { model: @seat }, status: :unprocessable_entity
      end
    end

    def show
    end

    def edit
    end

    def update
      @seat.assign_attributes(seat_params)

      unless @seat.save
        render :edit, locals: { model: @seat }, status: :unprocessable_entity
      end
    end

    def destroy
      @seat.destroy
    end

    private
    def set_place
      @place = Place.find params[:place_id]
    end

    def set_seat
      @seat = Seat.find(params[:id])
    end

    def seat_params
      params.fetch(:seat, {}).permit(
        :name,
        :max_members,
        :min_members
      )
    end

  end
end
