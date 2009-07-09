class Image < ActiveRecord::Base
  include ActionView::Helpers::DateHelper
  
  has_attached_file :attachment, :styles => { :medium => "800x600>", :thumb => "180x150>" }
  belongs_to :user
  belongs_to :pub
  
  default_scope :order => "created_at DESC"
  named_scope(:latest, :limit => 4)

end
