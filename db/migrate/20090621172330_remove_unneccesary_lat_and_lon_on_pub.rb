class RemoveUnneccesaryLatAndLonOnPub < ActiveRecord::Migration
  def self.up
    remove_column :pubs, :lat
    remove_column :pubs, :lon
  end

  def self.down
    add_column :pubs, :lat, :decimal, :precision => 20, :scale => 20
    add_column :pubs, :lon, :decimal, :precision => 20, :scale => 20
  end
end
