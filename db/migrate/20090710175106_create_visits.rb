class CreateVisits < ActiveRecord::Migration
  def self.up
    create_table :visits do |t|
      t.integer :pub_id
      t.integer :user_id
      t.text :comments
      t.timestamps
    end
  end

  def self.down
    drop_table :visits
  end
end
