class CreatePortfolios < ActiveRecord::Migration
  def change
    create_table :portfolios do |t|
      t.integer :layout
      t.integer :theme
      t.integer :user_id
      t.integer :font_id
      t.boolean :published, :default => false
      t.timestamps
    end
  end
end
