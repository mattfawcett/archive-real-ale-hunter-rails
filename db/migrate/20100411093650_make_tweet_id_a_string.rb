class MakeTweetIdAString < ActiveRecord::Migration
  def self.up
    change_column :visits, :tweet_id, :string, :null => true
  end

  def self.down
    change_column :visits, :tweet_id, :integer, :null => true
  end
end
