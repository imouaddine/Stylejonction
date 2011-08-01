class CreateCustomBackgrounds < ActiveRecord::Migration
  def change
    create_table :custom_backgrounds do |t|
      t.string :name
      t.integer :image_id
      t.string :display_mode, :default => 'original'
      t.integer :user_id

      t.timestamps
    end
  end
end
