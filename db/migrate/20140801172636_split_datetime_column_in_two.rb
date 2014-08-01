class SplitDatetimeColumnInTwo < ActiveRecord::Migration
  def up
    remove_column :reservations, :time
    add_column :reservations, :time, :time
    add_column :reservations, :date, :date
  end

  def down
    remove_column :reservations, :time
    remove_column :reservations, :date    
    add_column :reservations, :time, :datetime
  end
end
