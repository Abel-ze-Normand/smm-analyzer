class Theme < ApplicationRecord
  belongs_to :group
  has_many :group_posts
  validates_presence_of :name
  validates_presence_of :hashtag
  validates_uniqueness_of :name, scope: [:group_id]
end
