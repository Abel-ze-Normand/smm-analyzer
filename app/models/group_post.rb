class GroupPost < ApplicationRecord
  belongs_to :group
  belongs_to :group_stat

  # TODO: parse date from unix epoch to datetime format with Time.at(arg)
end
