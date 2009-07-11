class Pub < ActiveRecord::Base
  belongs_to :user
  has_many :beers, :as => :parent
  has_many :images
  has_many :visits
  
  validates_presence_of :name
  validates_presence_of :address_1
  validates_presence_of :town
  validates_presence_of :description
  validates_presence_of :post_code
  validates_format_of :post_code, :with => /^[a-zA-Z]{1,2}[0-9]{1,2} [0-9]{1}[a-zA-Z]{2}$/
  
  before_validation :clean_post_code, :clean_website
  acts_as_mappable
  
  named_scope :for_map, :select => "id, lat, lng, name, address_1, address_2, town, post_code, telephone"
  
  
  has_friendly_id :name_and_town, :use_slug => true
  
  accepts_nested_attributes_for :beers, :allow_destroy => true, :reject_if => proc { |attrs| attrs.all? { |k, v| v.blank? } }

  def validate_on_create
    geo = Geokit::Geocoders::MultiGeocoder.geocode(address)
    errors.add(:address, "Could not Geocode address") if !geo.success
    self.lat, self.lng = geo.lat,geo.lng if geo.success
  end

  
  def clean_post_code
    unless self.post_code.nil? || self.post_code =~ /^[a-zA-Z]{1,2}[0-9]{1,2} [0-9]{1}[a-zA-Z]{2}$/
      self.post_code = self.post_code.slice(0, self.post_code.length - 3) + " " + self.post_code.slice(self.post_code.length-3, 3)
    end
  end
  
  def clean_website
    unless website.blank? || website =~ /http(s)?:\/\//
      self.website = "http://#{website}"
    end
  end
  
  
  def address
    [address_1, address_2, town, post_code].compact.join(", ")
  end
  
  def name_and_town
    "#{name} - #{town}"
  end
  
  def has_images?
    images.length > 0
  end
  
  def has_visits?
    visits.length > 0
  end
 
end
