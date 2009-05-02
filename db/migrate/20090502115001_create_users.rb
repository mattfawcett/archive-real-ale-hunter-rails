class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :username
      t.string :email
      t.string :level
      t.string :pints
      t.decimal :memory_lat, :precision => 20, :scale => 20
      t.decimal :memory_lon, :precision => 20, :scale => 20
      t.integer :memory_zoom
      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
