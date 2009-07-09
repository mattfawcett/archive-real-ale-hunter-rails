class RemoveImageDescription < ActiveRecord::Migration
  def self.up
    remove_column :images, :description
  end

  def self.down
    add_column :images, :description, :string, :null => false
  end
end
