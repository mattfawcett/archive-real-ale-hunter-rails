class PubsController < ApplicationController
  before_filter :authenticate_user!, :only => [:new, :create, :edit, :update]
  layout :which_layout?

  def index
    @page_title = "Pubs"
    @pubs = collection
    respond_to do |format|
      format.json { render :json => collection.to_json }
      format.js {}
      format.html {}
    end
  end

  def edit
    @pub = Pub.find(params[:id])
    @pub.beers.build if @pub.beers.empty?
  end

  def update
    @pub = Pub.find(params[:id])
    if @pub.update_attributes(params[:pub])
      flash[:notice] = "Details updated"
      redirect_to @pub
    else
      render :action => "edit"
    end
  end

  def new
    @pub = Pub.new
    @pub.beers.build
  end

  def show
    @pub = Pub.find(params[:id])
    @page_title = "#{@pub.name} - #{@pub.town}"
    respond_to do |format|
      format.html { redirect_to @pub, :status => 301 unless request.path == pub_path(@pub) }
      format.json { render :json => @pub.to_json(:methods => :slug) }
    end
  end

  def create
    @pub = Pub.new(params[:pub])
    @pub.user = @current_user
    if @pub.save
      flash[:notice] = 'Thanks, The pub has been added'
      redirect_to pub_path(@pub)
    else
      render :action => 'new'
    end
  end

  private
  def which_layout?
    params[:action] == 'index' ? 'two_column' : 'one_column'
  end

  def collection
    if params[:format] == 'json'
      if params[:lat] && params[:lon]
        #iphone request, get 5 closet pubs
        Pub.find(:all, :origin =>[params[:lat],params[:lon]], :within => 100, :order => :distance, :limit => params[:limit] || 5)
      else
        #get all pubs with minimal details for clustering
        Pub.all_optimised_for_cluster_for_map
      end
    elsif params[:format] == 'js'
      #get details for a limited amount of pubs. but full details
      Pub.within_boundreys(params[:min_lat], params[:max_lat], params[:min_lng], params[:max_lng])
    else
      if(params[:town_id])
        #limit to a town
        Pub.in_town(params[:town_id]).beginning_with_letter(params[:letter]).paginate(:page => params[:page], :per_page => 200)
      else
        Pub.beginning_with_letter(params[:letter]).paginate(:page => params[:page], :per_page => 200)
      end
    end
  end

end
