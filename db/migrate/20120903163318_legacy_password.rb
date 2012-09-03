class LegacyPassword < ActiveRecord::Migration
  def up
    add_column :users, :legacy_password, :boolean, :default => false
    User.update_all(:legacy_password => true)
  end

  def down
    remove_column :users, :legacy_password
  end
end
