class SlugOnPub < ActiveRecord::Migration
  def up
    rename_table :slugs, :friendly_id_slugs
    add_column :pubs, :slug, :string
    rename_column :friendly_id_slugs, :name, :slug
    Pub.all.each do |p|
      p.slug = p.slugs.first.slug
      p.save(:validate => false)
    end
  end

  def down
    rename_table :friendly_id_slugs, :slugs
    remove_column :pubs, :slug
  end
end
