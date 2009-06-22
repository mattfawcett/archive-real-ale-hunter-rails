class Pub < ActiveRecord::Base
  belongs_to :user
  validates_presence_of(:name)
  validates_presence_of(:address_1)
  validates_presence_of(:town)
  validates_presence_of(:description)
  validates_presence_of(:post_code)
  validates_format_of(:post_code, :with => /^[a-zA-Z]{1,2}[0-9]{1,2} [0-9]{1}[a-zA-Z]{2}$/)
  
  before_validation :clean_post_code
  
  acts_as_geocodable :address => {:street => :address_1, :locality => :town, :region => :state, :postal_code => :post_code}
  has_friendly_id :name_and_town, :use_slug => true

  
  
  def clean_post_code
    unless self.post_code.nil? || self.post_code =~ /^[a-zA-Z]{1,2}[0-9]{1,2} [0-9]{1}[a-zA-Z]{2}$/
      self.post_code = self.post_code.slice(0, self.post_code.length - 3) + " " + self.post_code.slice(self.post_code.length-3, 3)
    end
  end
  
  
  def state
    "UK"
  end
  
  def name_and_town
    "#{name} in #{town}"
  end
end
