class Group < ApplicationRecord
  belongs_to :user
  has_many :themes, dependent: :destroy
  has_many :group_stats, dependent: :destroy
  has_many :group_posts, dependent: :destroy
  validates :stat_job_status, inclusion: { in: %w(not_started running done) }
  validates :posts_job_status, inclusion: { in: %w(not_started running done) }
  validates_uniqueness_of :id, scope: [:name, :user_id]

  def posts_job_running?
    posts_job_status == "running"
  end

  def posts_job_done?
    posts_job_status == "done"
  end

  def stats_job_running?
    stat_job_status == "running"
  end

  def stats_job_done?
    stat_job_status == "done"
  end
end
