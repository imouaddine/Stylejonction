class CreateGalleries < ActiveRecord::Migration
  def change
    create_table :galleries do |t|
      t.string :title
      t.string :display_type, :default => 'slideshow'
      t.integer :project_id

      t.timestamps
    end
  end
end
