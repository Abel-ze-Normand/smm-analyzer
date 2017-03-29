class Theme < ApplicationRecord
  belongs_to :group
  has_many :group_posts
  validates_presence_of :name
  validates_presence_of :hashtag
  validates_uniqueness_of :name, scope: [:group_id]

  def get_stats
    return render_stats if stats_mean_likes
    refresh_stats
  end

  def refresh_stats
    CalculateThemeStatsService.new(theme: self).call
    render_stats
  end

  def render_stats
    {
      mean_likes: stat_mean_likes,
      var_likes: stat_var_likes,
      mean_reposts: stat_mean_reposts,
      var_reposts: stat_var_reposts,
      mean_views: stat_mean_views,
      var_views: stat_var_views,
      mean_comments_count: stat_mean_comments_count,
      var_comments_count: stat_var_comments_count
    }
  end

  def stats_likes_converged
    stat_mean_likes - Math.sqrt(stat_var_likes)
  end

  def stats_reposts_converged
    stat_mean_reposts - Math.sqrt(stat_var_reposts)
  end

  def stats_views_converged
    stat_mean_reposts - Math.sqrt(stat_var_views)
  end

  def stats_comments_count_converged
    stat_mean_comments_count - Math.sqrt(stat_var_comments_count)
  end

  def stats_accumulated
    stats_likes_converged +
      1.5 * stats_reposts_converged +
      0.1 * stats_views_converged +
      0.7 * stats_comments_count_converged
  end
end
