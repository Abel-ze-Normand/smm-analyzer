# coding: utf-8
class DashboardController < ApplicationController
  before_action :require_login

  def index
    context_data = LoadDashboardDataService.new(user: @current_user).call
    @users_vk_group_list = load_groups_from_vk
    @users_added_group_list = context_data[:groups]
  end

  # remove?
  # def groups_list
  #   load_groups_from_vk
  # end

  # def pick_group
  #   # @todo Перенести в правильное место
  #   @client = VkClient.new
  #   group_info = @client.get_groups(141736779);
  #   abort group_info.inspect
  #   Vk::StoreGroupsService.new(strong_groups_list_params).call
  #   # @todo Вернуть json
  #   redirect_to dashboard_path
  # end

  private

  def strong_groups_list_params
    params.require(:groups)
  end

  def load_groups_from_vk
    @groups = Vk::GroupScannerService.new(session).call
  end
end
