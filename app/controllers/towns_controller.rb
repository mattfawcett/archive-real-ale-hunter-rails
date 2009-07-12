class TownsController < ApplicationController
  layout "two_column"
  
  def index
    @towns = Pub.towns 
    @tab = "Towns"
  end
end
