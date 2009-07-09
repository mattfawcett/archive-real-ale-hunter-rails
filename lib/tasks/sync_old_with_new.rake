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
    new_pub = Pub.new(:name => old_pub.name, :description => old_pub.description,
                      :address_1 => old_pub.address_1, :address_2 => old_pub.address_2,
                      :town => old_pub.town, :post_code => old_pub.post_code,
                      :telephone => old_pub.telephone, 
                      :number_of_pumps => old_pub.number_of_pumps, 
                      :gbg => gbg, :cask_marque => old_pub.cask_marque == 1 ? true : false
                      )
    new_pub.save(false)       
  end
  
end








module OldSite
  establish_connection :old_site
end

class Location < ActiveRecord::Base
  
end
