class TownsController < ApplicationController
  
  def index
    @towns = Pub.towns 
    @tab = "Towns"
    @page_title = "Towns"
  end
end
