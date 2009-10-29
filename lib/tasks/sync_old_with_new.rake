require 'magic_multi_connections'

desc "Sync"
task :sync_old_with_new => :environment do
  Pub.destroy_all
  Image.destroy_all
  Beer.destroy_all
  Visit.destroy_all
  User.destroy_all
  
  OldSite::User.all.each do |old_user|
    User.create!(:username => old_user.user_name, :email => old_user.email_address,
                 :level => old_user.user_level, :pints => old_user.pints)
  end
  
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
                      :website => old_pub.website_from_description,
                      :created_at => old_pub.date_added, :updated_at => old_pub.date_added,
                      :user_id => old_pub.added_by
                      )
    new_pub.save(false) 
    OldSite::Image.find_by_sql(" SELECT * FROM images WHERE pub_id = '#{old_pub.id}' ").each do |old_image|
      new_image = new_pub.images.new
      new_image.attachment_file_name = ''
      new_image = new_pub.images.new( :user_id => old_image.member_id,
                                      :name => old_image.description,
                                      :created_at => Time.at(old_image.upload_time),
                                      :updated_at => Time.at(old_image.upload_time),
                                      :attachment => File.new("/Users/mattfawcett/workspace/real-ale-hunter/application/upload/image#{old_image.id}.jpg"))     
      new_image.save!
    end
    
    OldSite::PubBeer.find_by_sql("SELECT * FROM pub_beers WHERE pub_id = '#{old_pub.id}' ").each do |pub_beer|      
      old_beer = OldSite::Beer.find_by_id(pub_beer.beer_id)
      if old_beer
        old_brewery = OldSite::Brewery.find_by_id(old_beer.brewery_id)
        if old_brewery
          beer_name = old_beer.beer_name + " - " + old_brewery.brewery_name       
          Beer.create!(:name => beer_name, :parent_type => "Pub", :parent_id => new_pub.id)
        end
      end
    end
    
    OldSite::Visit.find_by_sql("SELECT * FROM visits WHERE pub_id = '#{old_pub.id}' ").each do |old_visit|
      new_visit = new_pub.visits.create!(:comments => old_visit.comments.gsub(/<br(\s)?\/>/, "\n").gsub(/\\'/, "'"), :user_id => old_visit.member_id, :created_at => old_visit.date, :updated_at => old_visit.date)
      OldSite::VisitBeer.find_by_sql("SELECT * FROM visit_beers WHERE visit_id = '#{old_visit.id}' ").each do |visit_beer|      
        old_beer = OldSite::Beer.find_by_id(visit_beer.beer_id)
        if old_beer
          old_brewery = OldSite::Brewery.find_by_id(old_beer.brewery_id)
          if old_brewery
            beer_name = old_beer.beer_name + " - " + old_brewery.brewery_name 
        
            Beer.create!(:name => beer_name, :parent_type => "Visit", :parent_id => new_visit.id)
          end
        end
      end
    end
  end
  
end




module OldSite
  establish_connection :old_site
  
    
end

class Location < ActiveRecord::Base
  has_many :visits, :foreign_key => "pub_id"
  
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

class Brewery < ActiveRecord::Base
  has_many :beers
end


class PubBeer < ActiveRecord::Base
  belongs_to :pub
  belongs_to :beer
end

class VisitBeer < ActiveRecord::Base
  belongs_to :pub
  belongs_to :beer
end
