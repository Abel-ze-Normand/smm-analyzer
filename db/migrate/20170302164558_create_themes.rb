class CreateThemes < ActiveRecord::Migration[5.0]
  def change
    create_table :themes do |t|
      t.string :name
      t.timestamps
    end
    add_reference :themes, :group, foreign_key: true
  end
end
