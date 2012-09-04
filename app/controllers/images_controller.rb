class ImagesController < ApplicationController
  before_filter :authenticate_user!, :only => [:new, :create]
  before_filter :find_pub
  before_filter :redirect_to_best_pub_id, :only => [:index]

  def new
    @image = @pub.images.new
  end

  def index
    @page_title = "Photos of #{@pub.name} - #{@pub.town}"
  end

  def create
    @image = @pub.images.new(params[:image])
    @image.user = current_user
    if @image.save
      flash[:notice] = "Thanks, your photo has been uploaded"
      redirect_to pub_images_path(@pub)
    else
      render :action => :new
    end
  end

  private
  def redirect_to_best_pub_id
    redirect_to pub_images_path(@pub), :status => 301 unless @pub.slug == params[:pub_id]
  end
end
