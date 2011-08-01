class CreatePredefinedBackgrounds < ActiveRecord::Migration
  def change
    create_table :predefined_backgrounds do |t|
      t.string :name
      t.integer :image_id

      t.timestamps
    end
  end
end
