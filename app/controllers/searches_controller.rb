class SearchesController < ApplicationController
  def index
    @results = Pub.search(params[:terms], :page => params[:page], :per_page => 50)
  end
end
