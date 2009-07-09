class AddWebsiteToPubs < ActiveRecord::Migration
  def self.up
    add_column :pubs, :website, :string, :null => true
  end

  def self.down
    remove_column :pubs, :website
  end
end
