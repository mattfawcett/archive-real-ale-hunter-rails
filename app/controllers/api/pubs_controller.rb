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
    render :json => @pub.to_json(:methods => [:number_of_ratings, :number_of_images, :average_ratings])
  end
end
