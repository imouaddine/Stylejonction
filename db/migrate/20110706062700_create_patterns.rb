class CreatePatterns < ActiveRecord::Migration
  def change
    create_table :patterns do |t|
      t.string :title
      t.integer :image_id

      t.timestamps
    end
  end
end
