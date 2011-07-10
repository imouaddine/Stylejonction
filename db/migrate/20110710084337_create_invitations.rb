class CreateInvitations < ActiveRecord::Migration
  def change
    create_table :invitations do |t|
      t.string :email
      t.string :token
      t.boolean :used, :default => false
      t.datetime :expires
      t.integer :project_id

      t.timestamps
    end
  end
end
