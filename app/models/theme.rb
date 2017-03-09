class Theme < ApplicationRecord
  belongs_to :group
  validates_presence_of :name
  validates_uniqueness_of :name, scope: [:group_id]
end
