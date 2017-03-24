class Theme < ApplicationRecord
  belongs_to :group
  has_many :group_posts
  validates_presence_of :name
  validates_presence_of :hashtag
  validates_uniqueness_of :name, scope: [:group_id]

  def get_stats
    return render_stats if stats_mean_likes
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
      var_views: stat_var_views
    }
  end
end
