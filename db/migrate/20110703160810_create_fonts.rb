class CreateFonts < ActiveRecord::Migration
  def change
    create_table :fonts do |t|
      t.string :name
      t.string :provider
      t.string :url
      t.string :title
      t.string :color
      t.boolean :visible, :default => true
      t.timestamps
    end
  end
end
