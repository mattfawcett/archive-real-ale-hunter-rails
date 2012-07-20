class RenameSlugs < ActiveRecord::Migration
  def up
    rename_table :slugs, :friendly_id_slugs
  end

  def down
    rename_table :friendly_id_slugs, :slugs
  end
end
