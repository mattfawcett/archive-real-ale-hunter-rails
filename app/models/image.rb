class Image < ActiveRecord::Base
  include ActionView::Helpers::DateHelper
  
  has_attached_file :attachment, :styles => { :medium => "800x600>", :thumb => "180x150>", :big_thumb => "270x225>" },
                                 :url => "/system/attachments/:id/:style/:basename.:extension"
  validates_attachment_presence :attachment
  belongs_to :user
  belongs_to :pub
  
  default_scope :order => "created_at DESC"
  scope :latest, lambda{|n| {:limit => n}}
  after_create :award_pints
  
  def award_pints
    user.add_pints(3)
  end

  def files
    file_urls = {:original => attachment.url}
    [:medium, :thumb, :big_thumb].each {|size| file_urls[size] = attachment.url(size)}
    return file_urls
  end
end
