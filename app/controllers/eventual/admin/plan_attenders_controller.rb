module Eventual
  class Admin::PlanAttendersController < Admin::BaseController
    before_action :set_plan_item
    before_action :set_plan_attender, only: [:edit, :update, :attend, :absent]

    def index
      @plan_item.plan_participants.each(&:sync)
      @plan_attenders = @plan_item.plan_attenders
    end

    def create
      @plan_attender = @plan_item.plan_attenders.build(plan_participant_id: params[:plan_participant_id])
      @plan_attender.attended = true

      unless @plan_attender.save
        render :new, locals: { model: @plan_attender }, status: :unprocessable_entity
      end
    end

    def edit
    end

    def attend
      @plan_attender.attended = true
      @plan_attender.save
    end

    def absent
      @plan_attender.attended = false
      @plan_attender.save
    end

    def update
      @plan_attender.assign_attributes(plan_attender_params)

      unless @plan_attender.save
        render :edit, locals: { model: @plan_attender }, status: :unprocessable_entity
      end
    end

    def destroy
      @plan_attender = @plan_item.plan_attenders.find_by(plan_participant_id: params[:plan_participant_id])
      @plan_attender.destroy
    end

    private
    def set_plan_item
      @plan_item = PlanItem.find params[:plan_item_id]
    end

    def set_plan_attender
      @plan_attender = @plan_item.plan_attenders.find(params[:id])
    end

    def plan_attender_params
      params.fetch(:plan_attender, {}).permit(
        :state,
        :attender_type,
        :attender_id,
        :attended
      )
    end

  end
end
