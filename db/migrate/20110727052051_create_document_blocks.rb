class CreateDocumentBlocks < ActiveRecord::Migration
  def change
    create_table :document_blocks do |t|
      t.string :title
      t.integer :weight
      t.integer :project_id

      t.timestamps
    end
  end
end
