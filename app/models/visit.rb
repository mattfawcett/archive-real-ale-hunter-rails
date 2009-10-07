class Visit < ActiveRecord::Base
  belongs_to :pub
  belongs_to :user
  has_many :beers, :as => :parent
  
  default_scope :order => "created_at DESC"
  named_scope :latest, lambda{|n| {:limit => n}}
  
  accepts_nested_attributes_for :beers, :allow_destroy => true, :reject_if => proc { |attrs| attrs.all? { |k, v| v.blank? }}
  
  after_create :award_pints
  
  def award_pints
    user.add_pints(3)
  end
end
