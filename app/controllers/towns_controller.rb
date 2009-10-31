class TownsController < ApplicationController
  
  def index
    @towns = Pub.towns 
    @tab = "Towns"
  end
end
