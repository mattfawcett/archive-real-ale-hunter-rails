class UsersController < ApplicationController
  before_filter :require_login
  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update_attributes(:twitter_username => params[:user][:twitter_username])
      flash[:notice] = "Your twitter username has been updated"
      redirect_to edit_user_path
    else
      render :action => "edit"
    end
  end
end
