class AddStatsToThemeTable < ActiveRecord::Migration[5.0]
  def change
    add_column :group_posts, :reposts, :integer, default: 0
    add_column :group_posts, :views, :integer, default: 0
    change_column :group_posts, :likes_count, :integer, default: 0
    add_column :themes, :stat_mean_likes, :float
    add_column :themes, :stat_var_likes, :float
    add_column :themes, :stat_mean_reposts, :float
    add_column :themes, :stat_var_reposts, :float
    add_column :themes, :stat_mean_views, :float
    add_column :themes, :stat_var_views, :float
  end
end
