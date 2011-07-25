class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.string  :caption
      t.string  :url
      t.integer :gallery_id
      t.integer :weight,  :default => 0
      t.string  :provider_name
      t.integer :thumbnail_width
      t.integer :thumbnail_height
      t.string  :thumbnail_url
      t.string  :html
      
      t.timestamps
    end
  end
end
