class AddCommentsCountToPost < ActiveRecord::Migration[5.0]
  def change
    add_column :group_posts, :comments_count, :integer, default: 0
  end
end
