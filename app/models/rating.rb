class Rating < ActiveRecord::Base
  belongs_to :pub
  belongs_to :user
  validates_uniqueness_of :pub_id, :scope => [:user_id]
  validates_numericality_of :beer_quality, :beer_selection, :atmosphere, :price, :overall_option, :greater_than_or_equal_to => 0, :less_than_or_equal_to => 10
  
  after_create :award_pints
  
  def award_pints
    user.add_pints(3)
  end
end
