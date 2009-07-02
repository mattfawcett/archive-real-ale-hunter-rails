class User < ActiveRecord::Base
  has_many :pubs
  has_many :images
end
