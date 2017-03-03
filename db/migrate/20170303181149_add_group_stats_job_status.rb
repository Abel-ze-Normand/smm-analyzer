class AddGroupStatsJobStatus < ActiveRecord::Migration[5.0]
  def change
    add_column :groups, :stat_job_status, :string
    add_column :groups, :stat_job_id, :string
    add_column :groups, :posts_job_status, :string
    add_column :groups, :posts_job_id, :string
  end
end
