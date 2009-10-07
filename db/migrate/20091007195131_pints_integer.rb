class PintsInteger < ActiveRecord::Migration
  def self.up
    change_column :users, :pints, :integer, :null => false, :default => 0
  end

  def self.down
  end
end
