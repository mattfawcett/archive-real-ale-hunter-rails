class CreatePubs < ActiveRecord::Migration
  def self.up
    create_table :pubs do |t|
      t.decimal :lat, :precision => 20, :scale => 20
      t.decimal :lon, :precision => 20, :scale => 20
      t.string :name
      t.text :description
      t.string :address_1
      t.string :address_2, :null => true
      t.string :town
      t.string :post_code
      t.string :telephone, :null => true
      t.integer :number_of_pumps, :null => true, :default => nil
      t.integer :user_id
      t.boolean :gbg, :null => true, :default => nil
      t.boolean :cask_marque, :default => false
      t.timestamps
    end
  end

  def self.down
    drop_table :pubs
  end
end
