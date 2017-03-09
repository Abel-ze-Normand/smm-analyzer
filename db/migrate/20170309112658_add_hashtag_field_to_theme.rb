class AddHashtagFieldToTheme < ActiveRecord::Migration[5.0]
  def change
    add_column :themes, :hashtag, :string
  end
end
