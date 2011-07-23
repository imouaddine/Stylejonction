class CreateFonts < ActiveRecord::Migration
  def change
    create_table :fonts do |t|
      t.string :name
      t.string :provider
      t.string :url
      t.string :title
      t.boolean :visible, :default => true
      t.boolean :title_font, :default => false
      t.boolean :body_font, :default => false
      t.boolean :title_suggested, :default => false
      t.boolean :body_suggested, :default => false
      
      
      t.timestamps
    end
  end
end
