class CachePopularThemesService
  def initialize(options = {})
    @group_id = options.fetch(:group_id)
    @user_id = options.fetch(:user_id)
    @themes = options.fetch(:themes)
  end

  def call
    CacheService.set("popular-themes-#{@user_id}-#{@group_id}", @themes.to_json, 24.hours)
  end
end
