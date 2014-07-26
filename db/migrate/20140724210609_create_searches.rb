class CreateSearches < ActiveRecord::Migration
  def change
    create_table :searches do |t|
      t.text :restaurant_ids
      t.text :category_ids

      t.timestamps
    end
  end
end
