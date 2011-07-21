class CreatePatternBackgrounds < ActiveRecord::Migration
  def change
    create_table :pattern_backgrounds do |t|
      t.string :name
      t.string :color, :default => 'FFFFF'
      t.integer :pattern_id

      t.timestamps
    end
  end
end
