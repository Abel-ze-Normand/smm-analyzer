# coding: utf-8
class DashboardController < ApplicationController
  before_action :require_login

  def index
    @users_vk_group_list = groups_list
    @users_added_group_list = groups_list
  end

  def groups_list
    @groups = Vk::GroupScannerService.new(session).call
  end

  def pick_groups
    # @todo Перенести в правильное место
    @client = VkClient.new
    group_info = @client.get_groups(141736779);
    abort group_info.inspect
    Vk::StoreGroupsService.new(strong_groups_list_params).call
    # @todo Вернуть json
    redirect_to dashboard_path
  end

  private

  def strong_groups_list_params
    params.require(:groups)
  end
end
