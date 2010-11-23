class Api::PubsController < ApplicationController
  def search
    if params[:by] == "town"
      @pubs = Pub.search("*", :conditions => {params[:by] => params[:q]})
    elsif params[:by] == "name"
      @pubs = Pub.search("*", :conditions => {params[:by] => params[:q]})
    else
      @pubs = Pub.search(params[:q])
    end
    render :json => @pubs.to_json
  end
  
  def show
    @pub = Pub.find(params[:id])
    methods = [:number_of_ratings]
    methods << :average_ratings if @pub.has_ratings?
    render :json => @pub.to_json(:methods => methods)
  end
end
