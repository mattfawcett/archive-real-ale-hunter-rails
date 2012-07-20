class ImagesController < ApplicationController
  before_filter :require_login, :only => [:new, :create]
  before_filter :redirect_to_best_pub_id, :only => [:index]
  before_filter :find_pub

  def index
    @page_title = "Photos of #{@pub.name} - #{@pub.town}"
  end

  def create
    @image = @pub.images.new(params[:image])
    @image.user = @current_user
    if @image.save
      flash[:notice] = "Thanks, your photo has been uploaded"
      redirect_to pub_images_path(parent_object)
    else
      render :action => :new
    end
  end

  private
  def redirect_to_best_pub_id
    redirect_to pub_images_path(parent_object), :status => 301 unless parent_object.friendly_id_status.best?
  end
end
