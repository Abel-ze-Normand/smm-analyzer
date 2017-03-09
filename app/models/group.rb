class Group < ApplicationRecord
  belongs_to :user
  has_many :themes, dependent: :destroy
  has_one :group_stat, dependent: :destroy
  has_many :posts, dependent: :destroy
  validates :stat_job_status, inclusion: { in: %w(not_started running done) }
  validates :posts_job_status, inclusion: { in: %w(not_started running done) }
  validates_uniqueness_of :id, scope: [:name, :user_id, ]
end
