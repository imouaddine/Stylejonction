class CreateElements < ActiveRecord::Migration
  def change
    create_table :elements do |t|
      t.string :title
      t.integer :weight, :default => 0
      t.integer :project_id
      
      #wirting
      t.string :body
      
      #gallery
      t.string :display_preference, :default => 'mosaic'
      
      t.string :type
      

      t.timestamps
    end
  end
end
