class CreateImages < ActiveRecord::Migration
  def change
    create_table(:images) do |t|
      t.string  :image
      t.integer :edit_format_id
      t.integer :display_format_id
      t.integer :preview_format_id
      t.string  :content_type
      t.string  :file_size
      t.string  :dir
      t.boolean :scale_to_fit, :default => false
      t.integer :width
      t.integer :height
      t.boolean :editable, :default => false
      t.boolean :uploaded, :default => false
      t.timestamps
    end
    
    create_table(:image_formats) do |t|
      t.string  :format, :default => 'display'
      t.integer :height, :default => 0
      t.integer :width, :default => 0
      t.boolean :scalable, :default => true
      t.boolean :croppable, :default => true
      t.float :crop_x, :default => 0
      t.float :crop_y, :default => 0
    end
  end

 
end
