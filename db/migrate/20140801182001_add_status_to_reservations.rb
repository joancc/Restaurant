class AddStatusToReservations < ActiveRecord::Migration
  def up
    add_column :reservations, :status, :string
    add_index :reservations, :status
  end

  def down
    remove_column :reservations, :status
  end
end
