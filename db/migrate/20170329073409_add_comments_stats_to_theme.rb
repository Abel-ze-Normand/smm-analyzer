class AddCommentsStatsToTheme < ActiveRecord::Migration[5.0]
  def change
    add_column :themes, :stat_mean_comments_count, :float, default: 0.0
    add_column :themes, :stat_var_comments_count, :float, default: 0.0
  end
end
