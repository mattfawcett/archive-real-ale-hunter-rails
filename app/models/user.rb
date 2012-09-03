class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :username

  # login can contain username or email to allow logging in using either
  attr_accessible :login
  attr_accessor :login

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

  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    else
      where(conditions).first
    end
  end
end
