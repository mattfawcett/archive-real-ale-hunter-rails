class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
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
  
  def add_pints(number=0)
    self.update_attribute(:pints, self.pints += number)
  end
end
