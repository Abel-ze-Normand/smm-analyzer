class InitializeAllJob
  @queue = :default

  def self.perform(options = {})
    options = options.symbolize_keys
    group_id = options.fetch(:group_id)

    Theme.destroy_all
    GroupPost.destroy_all
    GroupStat.destroy_all

    load_posts(group_id, options)
    load_stats(group_id, options)
    analyze_popular_themes(group_id, options)
  end

  private

  def self.load_posts(group_id, options)
    GroupPost.where(group_id: group_id).destroy_all
    Vk::FullProcessPostsService.new(
      options.merge(
        loader: Vk::LoadPostsService,
        parser: Vk::ParsePostsService,
        analyzer: Vk::PostsAnalyzerService
      )
    ).call
    unlock_group_posts(group_id)
  rescue
    lock_group_posts(group_id)
  end

  def self.load_stats(group_id, options)
    GroupStat.where(group_id: group_id).destroy_all
    Vk::FullProcessStatsService.new(
      options.merge(
        loader: Vk::LoadStatsService,
        parser: Vk::ParseStatsService,
        analyzer: Vk::StatsAnalyzerService
      )
    ).call
    unlock_group_stats(group_id)
  rescue
    lock_group_stats(group_id)
  end

  def self.analyze_popular_themes(group_id, options)
    options.symbolize_keys!
    criteria = options[:criteria]
    ::Theme.transaction do
      Theme.where(group_id: group_id).each { |t| CalculateThemeStatsService.new(theme: t).call }
    end
    popular_themes = GetPopularThemesService.new(group_id: group_id, criteria: criteria).call
    CachePopularThemesService.new(user_id: Group.find(group_id).user_id, group_id: group_id, themes: popular_themes).call
  end

  def self.unlock_group_posts(group_id)
    Group.find(group_id).update_attributes(posts_job_status: "done")
  end

  def self.lock_group_posts(group_id)
    Group.find(group_id).update_attributes(posts_job_status: "not_started")
  end

  def self.unlock_group_stats(group_id)
    Group.find(group_id).update_attributes!(stat_job_status: "done")
  end

  def self.lock_group_stats(group_id)
    Group.find(group_id).update_attributes!(stat_job_status: "not_started")
  end
end
