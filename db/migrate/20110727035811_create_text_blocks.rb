class CreateTextBlocks < ActiveRecord::Migration
  def change
    create_table :text_blocks do |t|
      t.string :title
      t.string :body
      t.integer :project_id
      t.integer :weight, :default => true

      t.timestamps
    end
  end
end
