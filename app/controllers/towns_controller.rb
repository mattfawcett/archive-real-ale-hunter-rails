class TownsController < ApplicationController
  layout "two_column"
  
  def index
    @towns = Pub.towns 
  end
end
