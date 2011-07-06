class CreatePatternBackgrounds < ActiveRecord::Migration
  def change
    create_table :pattern_backgrounds do |t|
      t.string :name
      t.string :background
      t.string :color

      t.timestamps
    end
  end
end
