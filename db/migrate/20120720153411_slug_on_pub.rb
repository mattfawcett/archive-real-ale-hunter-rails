class SlugOnPub < ActiveRecord::Migration
  def up
    add_column :pubs, :slug, :string
    Pub.all.each do |p|
      p.slug = p.slugs.last
      p.save(:validate => false)
    end
    rename_column :friendly_id_slugs, :name, :slug
  end

  def down
    remove_column :pubs, :slug
    rename_column :friendly_id_slugs, :slug, :name
  end
end
