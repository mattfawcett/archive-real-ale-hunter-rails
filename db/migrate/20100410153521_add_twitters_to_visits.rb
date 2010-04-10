class AddTwittersToVisits < ActiveRecord::Migration
  def self.up
    add_column :visits, :tweet_id, :integer, :null => true
    add_column :visits, :tweet_username, :string, :null => true
  end

  def self.down
    remove_column :visits, :tweet_id
    remove_column :visits, :tweet_username
  end
end
