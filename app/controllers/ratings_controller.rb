class RatingsController < ApplicationController
  before_filter :authenticate_user!

  def new
    @pub = Pub.find(params[:pub_id])
    if current_user.has_rated?(@pub)
      redirect_to edit_pub_rating_path(@pub, current_user.rating_for(@pub))
    else
      @rating = @pub.ratings.new
    end
  end

  def edit
    @rating = current_user.ratings.find(params[:id])
    @pub = @rating.pub
  end

  def create
    @pub = Pub.find(params[:pub_id])
    @rating = Rating.new(params[:rating])
    @rating.pub = @pub
    @rating.user_id = current_user.id
    if @rating.save
      flash[:notice] = "Thanks, your rating has been added"
      redirect_to pub_path(@rating.pub)
    else
      render :action => "new"
    end
  end


  def update
    @rating = current_user.ratings.find(params[:id])
    @pub = @rating.pub
    if @rating.update_attributes(params[:rating])
      flash[:notice] = "Thanks, your rating has been updated"
      redirect_to pub_path(@rating.pub)
    else
      render :action => "edit"
    end
  end

end
