class CreateDocuments < ActiveRecord::Migration
  def change
    create_table :documents do |t|
      t.string :caption
      t.string :file
      t.string :content_type
      t.string :filesize
      t.integer :document_block_id
      t.integer :weight
      t.timestamps
    end
  end
end
