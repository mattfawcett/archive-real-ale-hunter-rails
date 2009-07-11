class Beer < ActiveRecord::Base
  #belongs_to :parent, :polymorphic => true
  validates_presence_of :name
end
