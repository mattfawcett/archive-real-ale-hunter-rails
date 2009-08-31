class User < ActiveRecord::Base
  has_many :pubs
  has_many :images
  has_many :visits
  has_many :ratings
  
  def has_rated?(pub)
    !rating_for(pub).nil?
  end
  
  def rating_for(pub)
    ratings.find_by_pub_id(pub.id)
  end
end
