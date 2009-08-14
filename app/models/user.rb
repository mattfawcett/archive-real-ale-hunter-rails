class User < ActiveRecord::Base
  has_many :pubs
  has_many :images
  has_many :visits
  has_many :ratings
end
