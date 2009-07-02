class Image < ActiveRecord::Base
  has_attached_file :attachment, :styles => { :medium => "800x600>", :thumb => "200x150>" }
  belongs_to :user
  belongs_to :pub
end
