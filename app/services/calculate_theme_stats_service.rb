class CalculateThemeStatsService
  def initialize(options = {})
    @theme = options.fetch(:theme)
  end

  def call
    gather_related_data
    calc_mean_likes
    calc_var_likes
    calc_mean_reposts
    calc_var_reposts
    calc_mean_views
    calc_var_views
    @theme.save!
  end

  private

  def gather_related_data
    @posts = @theme.group_posts
    @likes = @posts.pluck(:likes_count)
    @reposts = @posts.pluck(:reposts)
    @views = @posts.pluck(:views)
  end

  def calc_mean_likes
    @theme.stat_mean_likes = DescriptiveStatistics.mean(@likes)
  end

  def calc_var_likes
    @theme.stat_var_likes = DescriptiveStatistics.variance(@likes)
  end

  def calc_mean_reposts
    @theme.stat_mean_reposts = DescriptiveStatistics.mean(@reposts)
  end

  def calc_var_reposts
    @theme.stat_var_reposts = DescriptiveStatistics.variance(@reposts)
  end

  def calc_mean_views
    @theme.stat_mean_views = DescriptiveStatistics.mean(@views)
  end

  def calc_var_views
    @theme.stat_var_views = DescriptiveStatistics.variance(@views)
  end
end
