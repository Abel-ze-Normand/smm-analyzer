class DashboardController < ApplicationController
  before_action :require_login

  def index
  end

  def groups_list
    @groups = Vk::GroupScannerService.new(session).call
  end

  def pick_groups
    Vk::StoreGroupsService.new(strong_groups_list_params).call
    redirect_to dashboard_path
  end

  private

  def strong_groups_list_params
    params.require(:groups)
  end
end
