class CreateDocumentBlocks < ActiveRecord::Migration
  def change
    create_table :document_blocks do |t|
      t.string :title
      t.integer :weight, :default => 0
      t.integer :project_id

      t.timestamps
    end
  end
end
