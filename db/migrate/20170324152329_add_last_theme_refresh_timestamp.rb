class AddLastThemeRefreshTimestamp < ActiveRecord::Migration[5.0]
  def change
    add_column :themes, :last_refresh_timestamp, :datetime
  end
end
