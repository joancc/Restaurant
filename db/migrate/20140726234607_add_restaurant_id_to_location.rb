class AddRestaurantIdToLocation < ActiveRecord::Migration
  def up
    add_column :locations, :restaurant_id, :integer
  end

  def down
    remove_column :locations, :restaurant_id
  end

end
