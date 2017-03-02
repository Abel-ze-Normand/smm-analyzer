class Group < ApplicationRecord
  belongs_to :user
  has_many :themes
  has_one :group_stat
  has_many :posts
end
