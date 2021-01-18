module Eventual
  class Admin::CrowdMembersController < Admin::BaseController
    before_action :set_crowd

    def index
      @crowd_members = @crowd.crowd_members.page(params[:page])
    end

    def new
      @crowd_member = @crowd.crowd_members.build
    end

    def create
      @crowd_member = @crowd.crowd_members.build(crowd_member_params)

      unless @crowd_member.save
        render :new, locals: { model: @crowd_member }, status: :bad_request
      end
    end

    def destroy
      if params[:id]
        @crowd_member = @crowd.crowd_members.find(params[:id])
      elsif params[:member_id]
        @crowd_member = @crowd.crowd_members.find_by(member_id: params[:member_id])
      end

      @crowd_member.destroy if @crowd_member
    end

    private
    def set_crowd
      @crowd = Crowd.find params[:crowd_id]
    end

    def crowd_member_params
      params.fetch(:crowd_member, {}).permit(
        :member_id
      )
    end

  end
end
