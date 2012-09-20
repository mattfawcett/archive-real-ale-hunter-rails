class AdminFlag < ActiveRecord::Migration
  def up
    add_column :users, :admin, :boolean, :default => false
  end

  def down
    remove_column :users, :admin, :boolean
  end
end
