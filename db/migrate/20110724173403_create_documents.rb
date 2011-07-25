class CreateDocuments < ActiveRecord::Migration
  def change
    create_table :documents do |t|
      t.string :title
      t.string :file
      t.integer :document_block_id
      t.integer :weight, :default => 0

      t.timestamps
    end
  end
end
