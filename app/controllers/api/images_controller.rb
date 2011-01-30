class Api::ImagesController < ApplicationController
  def index
    @pub = Pub.find(params[:pub_id])
    render :json => @pub.images.to_json(:methods => :files)
  end
end
