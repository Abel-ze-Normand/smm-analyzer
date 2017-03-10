class FixGroupPostNaming < ActiveRecord::Migration[5.0]
  def change
    rename_column :group_stats, :unsubcribed_count, :unsubscribed_count
  end
end
