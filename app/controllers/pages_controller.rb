class PagesController < ApplicationController
  before_filter :set_tab_and_page_title
  # caches_page :index, :brewing_real_ale, :camra_campaign_for_real_ale, :links, 
  #             :styles_of_real_ale, :what_is_real_ale, :whats_new
   
  def whats_new
    @tab = "What's New"
    @pubs = Pub.latest 10
    @visits = Visit.latest 10
    @images = Image.latest 9
  end
  
  def sitemap
    render :template => "pages/sitemap.rxml", :layout => false
  end
  
  def setup_twitter
    if current_user
      redirect_to edit_user_path(current_user)
    else
      flash[:notice] = "Please login first"
      redirect_to "/"
    end
  end
  
  private
  def set_tab_and_page_title
    @tab = "Home"
    @page_title = params[:action].humanize
    @page_title = "CAMRA - The Campaign For Real Ale" if params[:action] == 'camra_campaign_for_real_ale'
    @page_title = "Home" if params[:action] == 'index'
  end  
end
