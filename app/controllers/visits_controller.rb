class VisitsController < ApplicationController
  before_filter :authenticate_user!, :only => [:new, :create]
  before_filter :find_pub

  layout "one_column"

  def new
    @visit = @pub.visits.new
    @visit.beers.build
  end

  def index
    @page_title = "Visits added to #{@pub.name} - #{@pub.town}"
    @visits = @pub.visits
  end

  def create
    @visit = @pub.visits.new(params[:visit])
    @visit.user = @current_user
    if @visit.save
      flash[:notice] =  "Thanks, your visit has been added"
      redirect_to pub_path(@pub)
    else
      render :action => "new"
    end
  end
end
