class CreatePortfolios < ActiveRecord::Migration
  def change
    create_table :portfolios do |t|
      t.integer :layout_id
      t.integer :theme
      t.integer :user_id
      t.integer :font_id
      t.integer :background_id
      t.string  :background_type
      t.boolean :published, :default => false
      t.timestamps
    end

    add_index :portfolios, :user_id
  end
end
