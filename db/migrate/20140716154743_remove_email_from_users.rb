class RemoveEmailFromUsers < ActiveRecord::Migration
  def up
    # remove_column :users, :email
  end

  def down
    remove_column :users, :email
    remove_column :users, :encrypted_password

      ## Recoverable
      remove_column :users, :reset_password_token
      remove_column :users, :reset_password_sent_at

      ## Rememberable
      remove_column :users, :remember_created_at

      ## Trackable
      remove_column :users, :sign_in_count, default: 0, null: false
      remove_column :users, :current_sign_in_at
      remove_column :users, :last_sign_in_at
      remove_column :users, :current_sign_in_ip
      remove_column :users, :last_sign_in_ip
  end
end
