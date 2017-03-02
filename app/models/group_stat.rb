class GroupStat < ApplicationRecord
  has_one :age_cluster
  belongs_to :group
  has_many :posts
end
