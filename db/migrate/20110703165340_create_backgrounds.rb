class CreateBackgrounds < ActiveRecord::Migration
  def change
    create_table :backgrounds do |t|
      t.integer :display_mode_id
      t.integer :color_id
      t.integer :pattern_id

      t.timestamps
    end
  end
end
