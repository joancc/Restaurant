class AddColumnsToUsers < ActiveRecord::Migration
  def up
    add_column :users, :provider, :string
    add_column :users, :uid, :string
    add_index(:users, :uid)
  end

  def down
    remove_column :users, :provider
    remove_column :users, :uid
  end

  
  
end
