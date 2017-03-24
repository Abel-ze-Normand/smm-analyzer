class CachePopularThemesService
  def initialize(options = {})
    @group_id = options.fetch(:group_id)
    @user_id = options.fetch(:user_id)
    @themes = options.fetch(:themes)
  end

  def call
    key = "popular-themes-#{@user_id}-#{@group_id}"
    $redis.set(key, @themes.to_json)
    $redis.expire(key, 24.hours)
  end
end
