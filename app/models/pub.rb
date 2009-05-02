class Pub < ActiveRecord::Base
  belongs_to :user
  validates_presence_of(:name)
  validates_presence_of(:address_1)
  validates_presence_of(:town)
  validates_presence_of(:description)
  validates_presence_of(:post_code)
  validates_format_of(:post_code, :with => /^[a-zA-Z]{1,2}[0-9]{1,2} [0-9]{1}[a-zA-Z]{2}$/)
  
  before_validation :clean_post_code
  
  def clean_post_code
    unless self.post_code.nil? || self.post_code =~ /^[a-zA-Z]{1,2}[0-9]{1,2} [0-9]{1}[a-zA-Z]{2}$/
      self.post_code = self.post_code.slice(0, self.post_code.length - 3) + " " + self.post_code.slice(self.post_code.length-3, 3)
    end
  end
end