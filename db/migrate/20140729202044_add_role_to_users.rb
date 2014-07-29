class AddRoleToUsers < ActiveRecord::Migration
  def up
    add_column :users, :role, :string, default: 'Patron'
  end

  def down
    drop_column :users, :role
  end
end
