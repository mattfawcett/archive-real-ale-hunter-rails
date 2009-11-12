class MapsController < ApplicationController
  layout 'one_column'
  
  def show
    @tab = "Map"
    @page_title = "Map"
  end
end
