class CreatePredefinedBackgrounds < ActiveRecord::Migration
  def change
    create_table :predefined_backgrounds do |t|
      t.string :name
      t.string :background

      t.timestamps
    end
  end
end
