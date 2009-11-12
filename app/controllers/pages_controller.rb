class PagesController < ApplicationController
  before_filter :set_tab_and_page_title
   
  def whats_new
    @tab = "What's New"
    @pubs = Pub.latest 10
    @visits = Visit.latest 10
    @images = Image.latest 9
  end
  
  private
  def set_tab_and_page_title
    @tab = "Home"
    @page_title = params[:action].humanize
    @page_title = "CAMRA - The Campaign For Real Ale" if params[:action] == 'camra_campaign_for_real_ale'
    @page_title = "Home" if params[:action] == 'index'
  end  
end
