class CreateCustomBackgrounds < ActiveRecord::Migration
  def change
    create_table :custom_backgrounds do |t|
      t.string :name
      t.string :background
      t.string :display_mode
      t.integer :user_id

      t.timestamps
    end
  end
end
