class PagesController < ApplicationController
  layout "two_column"
  before_filter :set_tab
   
  def whats_new
    @tab = "What's New"
    @pubs = Pub.latest 10
    @visits = Visit.latest 10
    @images = Image.latest 10
end
  
  private
  def set_tab
    @tab = "Home"
  end  
end
