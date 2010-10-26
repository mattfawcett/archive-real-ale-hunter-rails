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
end
