class PagesController < ApplicationController
  layout "two_column"
  before_filter :set_tab
   
  
  private
  def set_tab
    @tab = "Home"
  end
end
