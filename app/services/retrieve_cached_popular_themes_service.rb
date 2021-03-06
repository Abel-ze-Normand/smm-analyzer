class RetrieveCachedPopularThemesService
  def initialize(options = {})
    @group_id = options.fetch(:group_id)
    @user_id = options.fetch(:user_id)
  end

  def call
    CacheService.get("popular-themes-#{@user_id}-#{@group_id}")
  end
end
