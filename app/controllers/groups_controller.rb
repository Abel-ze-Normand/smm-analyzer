class GroupsController < ApplicationController
  before_action :require_login

  def create
    Vk::StoreGroupsService.new(
      group_id: strong_group_params[:group_id],
      action: :one,
      access_token: session[:access_token],
      user_id: @current_user.id,
      groups_loader: Vk::LoadGroupsService
    ).call
    redirect_to dashboard_path
  end

  def destroy
    ForgetGroupService.new(params).call
    redirect_to dashboard_path
  end

  private

  def strong_group_params
    params.permit(:group_id)
  end
end
