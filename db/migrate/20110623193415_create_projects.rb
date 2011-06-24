class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :title
      t.integer :portfolio_id
      t.string :cover
      
      
      
      t.timestamps
    end
  end
end
