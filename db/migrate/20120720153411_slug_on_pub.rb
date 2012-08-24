class SlugOnPub < ActiveRecord::Migration
  def up
    add_column :pubs, :slug, :string
    Pub.all.each do |p|
      p.slug = p.slugs.last
      p.save(:validate => false)
    end
  end

  def down
    remove_column :pubs, :slug
  end
end
