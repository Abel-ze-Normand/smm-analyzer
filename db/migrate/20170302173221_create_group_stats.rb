class CreateGroupStats < ActiveRecord::Migration[5.0]
  def change
    create_table :age_clusters do |t|
      t.integer :from_12_to_18_count
      t.integer :from_18_to_21_count
      t.integer :from_21_to_24_count
      t.integer :from_24_to_27_count
      t.integer :from_27_to_30_count
      t.integer :from_30_to_35_count
      t.integer :from_35_to_45_count
      t.integer :from_45_to_100_count
    end
    create_table :group_stats do |t|
      t.datetime :day
      t.integer :unique_visitors_count
      t.integer :subscribed_count
      t.integer :unsubcribed_count
      t.timestamps
    end
    add_reference :group_stats, :group, foreign_key: true
    add_reference :group_stats, :age_cluster, foreign_key: true
  end
end
