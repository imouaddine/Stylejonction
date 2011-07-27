class CreateGalleries < ActiveRecord::Migration
  def change
    create_table :galleries do |t|
      t.string :title
      t.integer :weight, :default => 0
      t.string :display_preference, :default => true
      t.integer :project_id

      t.timestamps
    end
  end
end
