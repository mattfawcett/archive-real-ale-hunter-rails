class AddDescriptionToImages < ActiveRecord::Migration
  def self.up
    add_column :images, :description, :string, :null => true
  end

  def self.down
    remove_column :images, :description
  end
end

