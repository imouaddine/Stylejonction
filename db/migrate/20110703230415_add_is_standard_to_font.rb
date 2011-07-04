class AddIsStandardToFont < ActiveRecord::Migration
  def change
      add_column :fonts, :standard, :boolean, :default => false
      remove_column :fonts, :title
  end
end
