class Pub < ActiveRecord::Base
  POSTCODE_REGEX = /^[a-zA-Z]{1,2}[0-9]{1,2}([a-zA-Z]{1})? [0-9]{1}[a-zA-Z]{2}$/
  belongs_to :user
  has_many :beers, :as => :parent
  has_many :images
  has_many :visits
  has_many :ratings

  validates_presence_of :name
  validates_presence_of :address_1
  validates_presence_of :town
  validates_presence_of :description
  validates_presence_of :post_code
  validates_format_of :post_code, :with => POSTCODE_REGEX

  before_validation :clean_post_code, :clean_website
  after_create :award_pints
  acts_as_mappable

  scope :all_optimised_for_cluster_for_map, :select => "id, lat, lng"
  scope :within_boundreys,  lambda {|min_lan, max_lat, min_lng, max_lng| {:conditions => ["lat >= ? AND lat <= ? AND lng >= ? AND lng <= ?", min_lan, max_lat, min_lng, max_lng]}}
  scope :in_town, lambda {|town| {:conditions => {:town => town}}}
  scope :beginning_with_letter, lambda {|letter| {:conditions => letter.nil? ? "" : ["UPPER(name) LIKE ?", "#{letter}%"]}}

  default_scope :order => :name

  extend FriendlyId
  friendly_id :name_and_town, :use => [:history]

  accepts_nested_attributes_for :beers, :allow_destroy => true, :reject_if => proc { |attrs| attrs.all? { |k, v| v.blank? } }

  validate :validate_geolocation, :on => :create

  def clean_post_code
    unless self.post_code.blank? || self.post_code =~ POSTCODE_REGEX
      self.post_code = self.post_code.slice(0, self.post_code.length - 3) + " " + self.post_code.slice(self.post_code.length-3, 3)
    end
  end

  def clean_website
    unless website.blank? || website =~ /http(s)?:\/\//
      self.website = "http://#{website}"
    end
  end

  def address(excerpts=false)
    field_names = %w(address_1 address_2 town post_code)
    fields = field_names.collect {|f| excerpts ? self.excerpts.send(f) : self.send(f)}
    fields.compact.delete_if{|x| x.blank? }.join(", ")
  end

  def name_and_town
    "#{name} - #{town}"
  end

  def has_images?
    number_of_images > 0
  end

  def has_visits?
    visits.length > 0
  end

  def has_ratings?
    number_of_ratings > 0
  end

  def number_of_ratings
    ratings.length
  end

  def number_of_images
    images.length
  end

  def self.towns
    Pub.unscoped.find(:all, :select => "DISTINCT(town) as town", :order => "town ASC").collect {|p| p.town}
  end

  def self.latest(n = 5)
    unscoped.order("created_at DESC").limit(n)
  end

  def average_ratings
    return nil unless has_ratings?
    results = {:beer_quality => 0, :beer_selection => 0, :atmosphere => 0, :price => 0, :overall_option => 0}
    ratings.each do |one_rating|
      results.each do |thing_to_rate, rating|
        results[thing_to_rate] += one_rating.send(thing_to_rate.to_s)
      end
    end
    results.each do |thing_to_rate, rating|
      results[thing_to_rate] = rating / ratings.length
    end
    return results
  end

  def award_pints
    user.add_pints(5)
  end

  define_index do
    # fields
    indexes name, :sortable => true
    indexes town
    indexes description
    indexes user.username, :as => :author, :sortable => true

    # attributes
    has user_id, created_at, updated_at
  end

  def validate_geolocation
    return unless lat.nil? && lng.nil?
    geo = Geokit::Geocoders::GoogleGeocoder3.geocode(address)
    errors.add(:address, "Could not Geocode address") if !geo.success
    self.lat, self.lng = geo.lat,geo.lng if geo.success
  end
end
