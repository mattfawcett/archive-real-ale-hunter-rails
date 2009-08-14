class CreateRatings < ActiveRecord::Migration
  def self.up
    create_table :ratings do |t|
      t.integer :pub_id
      t.integer :user_id
      t.integer :beer_quality
      t.integer :beer_selection
      t.integer :atmosphere
      t.integer :price
      t.integer :overall_option

      t.timestamps
    end
  end

  def self.down
    drop_table :ratings
  end
end
