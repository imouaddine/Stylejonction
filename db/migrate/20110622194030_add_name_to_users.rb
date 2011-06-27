class AddNameToUsers < ActiveRecord::Migration
  def change
    add_column :users, :username, :string, :unique => true
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :admin, :boolean, :default => false
  end
end
