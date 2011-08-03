class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.string :caption
      t.integer :gallery_id
      t.integer :image_id
      t.integer :weight

      t.timestamps
    end
  end
end
