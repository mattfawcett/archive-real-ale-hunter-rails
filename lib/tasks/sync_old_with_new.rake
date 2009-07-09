require 'rubygems'
require 'magic_multi_connections'




desc "Sync old with new"
task :sync_old_with_new => :environment do
  Pub.destroy_all
  
  OldSite::Location.all.each do |old_pub|
    if old_pub.gbg == 1
      gbg = true
    elsif old_pub.gbg == 0
      gbg = 0
    else
      gbg = nil
    end
    new_pub = Pub.new(:name => old_pub.name, :description => old_pub.clean_description,
                      :address_1 => old_pub.address_1, :address_2 => old_pub.address_2,
                      :town => old_pub.town, :post_code => old_pub.post_code,
                      :telephone => old_pub.telephone, 
                      :number_of_pumps => old_pub.number_of_pumps, 
                      :gbg => gbg, :cask_marque => old_pub.cask_marque == 1 ? true : false,
                      :lat => old_pub.lat, :lng => old_pub.lon,
                      :website => old_pub.website_from_description
                      )
    new_pub.save(false)       
  end
  
end








module OldSite
  establish_connection :old_site
end

class Location < ActiveRecord::Base
  def clean_description
    ret = description
    ret = ret.gsub(/<br(\s)?\/>/, "\n") # replace br tags
    ret = ret.gsub(/\\'/, "'")# fix the php \' issue
    ret = ret.gsub(/(Their website is at )?(See )?(((website)(:)?(\s)?))?<a href(.)*<\/a>/, '')#remove website
  end
  
  def website_from_description
    description[/<a href="(http:\/\/[^"]*)"/, 1]
  end
end
