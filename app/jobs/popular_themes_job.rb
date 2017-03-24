class PopularThemesJob
  @queue = :default

  def self.perform(options = {})
    options.symbolize_keys!
    group_id = options.fetch(:group_id)
    user_id = options.fetch(:user_id)
    criteria = options[:criteria]
    ::Theme.transaction do
      Theme.where(group_id: group_id).each { |t| CalculateThemeStatsService.new(theme: t).call }
    end
    popular_themes = GetPopularThemesService.new(group_id: group_id, criteria: criteria).call
    CachePopularThemesService.new(user_id: user_id, group_id: group_id, themes: popular_themes).call
  end
end
