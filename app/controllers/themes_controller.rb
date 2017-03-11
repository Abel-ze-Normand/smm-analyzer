class ThemesController < ApplicationController
  before_action :require_login

  def new
    @group = Group.find(params[:group_id])
    @theme = Theme.new(group_id: @group.id)
  end

  def create
    service_result = CreateThemeService.new(strong_theme_params).call
    unless service_result.successful?
      @theme = service_result.result
      respond_to do |f|
        f.html { render "dashboard/index"}
        f.js
      end
    else
      redirect_to dashboard_path
    end
  end

  def index
    result = GetThemesForGroupService.new(params).call
    @group = result[:group]
    @themes = result[:themes]
  end

  def destroy
    DeleteThemeService.new(params).call
    redirect_to dashboard_path
  end

  private

  def strong_theme_params
    params.require(:theme).permit(:id, :name, :group_id, :hashtag)
  end
end
