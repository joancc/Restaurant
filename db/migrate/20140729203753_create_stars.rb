class CreateStars < ActiveRecord::Migration
  def up
    create_table :stars do |t|
      t.integer :user_id
      t.integer :restaurant_id
      t.timestamps
    end
  end

  def down
    drop_table :stars
  end
end
