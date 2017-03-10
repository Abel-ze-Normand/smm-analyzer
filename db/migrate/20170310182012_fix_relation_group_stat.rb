class FixRelationGroupStat < ActiveRecord::Migration[5.0]
  def change
    remove_column :group_stats, :age_cluster_id
    add_reference :age_clusters, :group_stat, foreign_key: true
  end
end
