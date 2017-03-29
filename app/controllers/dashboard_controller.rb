# coding: utf-8
class DashboardController < ApplicationController
  before_action :require_login

  def index
    context_data = LoadDashboardDataService.new(
      user: @current_user,
      access_token: session[:access_token],
      entries: [:groups, :vk_groups, :theme]
    ).call
    @users_added_group_list = context_data[:groups]
    @users_vk_group_list = context_data[:vk_groups]
    @theme = context_data[:theme]
  end

  def initialize_all
    Vk::StartInitializeAllService.new(
      group_id: params[:group_id],
      access_token: session[:access_token],
      date_from: "1970-01-01",
      date_to: "2018-01-01"
    ).call
    redirect_to dashboard_path
  end

  private

  def strong_groups_list_params
    params.require(:groups)
  end
end
