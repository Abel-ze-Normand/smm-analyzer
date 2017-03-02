class CreateGroupPosts < ActiveRecord::Migration[5.0]
  def change
    create_table :group_posts do |t|
      t.text :text
      t.integer :likes_count
      t.datetime :date
      t.timestamps
    end
    add_reference :group_posts, :theme, foreign_key: true
    add_reference :group_posts, :group_stat, foreign_key: :true
  end
end
