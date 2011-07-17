class CreateImages < ActiveRecord::Migration
  def up
     create_table(:images) do |t|
       t.string  :image
       t.integer :thumb_format_id
       t.integer :original_format_id
        
     end
     create_table(:image_formats) do |t|
       t.integer :height
       t.integer :width
       t.boolean :scale_to_fit, :default => false
       t.string :name, :default => 'original'
       t.float :crop_x, :default => 0
       t.float :crop_y, :default => 0
     end
 
  end

  def down
  end
end
