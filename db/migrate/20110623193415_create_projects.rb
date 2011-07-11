class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :title
      t.integer :portfolio_id
      t.string  :cover
      t.boolean :default, :default => false
      t.boolean :public, :default => true
      t.timestamps
    end
  end
end
