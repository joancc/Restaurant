class AddUserIdToReservations < ActiveRecord::Migration
  def up
    add_column :reservations, :user_id, :integer
  end

  def down
    remove_column :reservations, :user_id
  end
end
