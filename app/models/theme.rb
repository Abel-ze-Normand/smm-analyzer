class Theme < ApplicationRecord
  belongs_to :group
  validates_presence_of :group_id
end
