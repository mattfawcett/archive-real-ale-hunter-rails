class Api::PubsController < ApplicationController
  def search
    if params[:by] == "town"
      @pubs = Pub.search("*", :conditions => {params[:by] => params[:q]})
    elsif params[:by] == "name"
      @pubs = Pub.search("*", :conditions => {params[:by] => params[:q]})
    else
      @pubs = Pub.search(params[:q])
    end
    render :json => @pubs.to_json(:methods => [:number_of_ratings, :number_of_images, :average_ratings])
  end

  def closest
    @pubs = Pub.find(:all, :origin =>[params[:lat],params[:lon]], :within => 100, :order => :distance, :limit => params[:limit] || 5).compact
    render :json => @pubs.to_json(:methods => [:number_of_ratings, :number_of_images, :average_ratings])
  end

  def show
    @pub = Pub.find(params[:id])
    render :json => @pub.to_json(:methods => [:number_of_ratings, :number_of_images, :average_ratings])
  end
end