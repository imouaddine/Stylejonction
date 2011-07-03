class CreateLayouts < ActiveRecord::Migration
  def change
    create_table :layouts do |t|
      t.string :name
      t.string :css_name

      t.timestamps
    end
  end
end
