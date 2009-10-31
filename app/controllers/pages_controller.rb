class PagesController < ApplicationController
  before_filter :set_tab
   
  def whats_new
    @tab = "What's New"
    @pubs = Pub.latest 10
    @visits = Visit.latest 10
    @images = Image.latest 9
  end
  
  private
  def set_tab
    @tab = "Home"
  end  
end
