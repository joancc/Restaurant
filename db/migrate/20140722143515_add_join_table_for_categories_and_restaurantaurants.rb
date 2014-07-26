class AddJoinTableForCategoriesAndRestaurantaurants < ActiveRecord::Migration
  def change
    create_table :categories_restaurants, id: false do |t|
      t.references :category
      t.references :restaurant
    end
  end
end
