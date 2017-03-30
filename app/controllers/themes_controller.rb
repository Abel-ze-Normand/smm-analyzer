class ThemesController < ApplicationController
  before_action :require_login, except: [:edit]

  def new
    @group = Group.find(params[:group_id])
    @theme = themes_repo.new(group_id: @group.id)
    # @theme = Theme.new(group_id: @group.id)
    respond_to do |f|
      f.js
    end
  end

  def create
    # service_result = CreateThemeService.new(strong_theme_params).call
    service_result = themes_repo.create(strong_theme_params)
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

  def edit
    # @theme = Theme.find(params[:id])
    @theme = themes_repo.find(params[:id])
    respond_to do |f|
      f.js
    end
  end

  def update
    # service_result = UpdateThemeService.new(strong_theme_params).call
    service_result = themes_repo.update(strong_theme_params)
    unless service_result.successful?
      @theme = service_result.result
      respond_to do |f|
        f.html { render "dashboard/index" }
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
    # DeleteThemeService.new(params).call
    themes_repo.destroy(params[:id])
    redirect_to dashboard_path
  end

  def analyze_popular
    StartPopularThemesAnalyzerService.new(group_id: params[:group_id]).call
    redirect_to dashboard_path
  end

  def popular
    @popular_themes = RetrieveCachedPopularThemesService.new(
      group_id: params[:group_id],
      user_id: @current_user.id
    ).call
    respond_to do |f|
      f.js
    end
  end

  def show_target_audience
    @theme = themes_repo.find(params[:theme_id])
  end

  def get_target_audience
    @target_audience_data = GetTargetAudienceService.new(theme_id: params[:theme_id]).call
    respond_to do |f|
      f.js
    end
  end

  private

  def strong_theme_params
    params.require(:theme).permit(:id, :name, :group_id, :hashtag)
  end

  def themes_repo
    @repo ||= ThemeRepository.new
  end
end
