class PubsController < ResourceController::Base
  layout :which_layout?
  caches_page :index
  
  index.wants.json do
    render :json => collection.to_json
  end 
  index.wants.html do
    render :template => "pubs/index.haml"
  end
  index.wants.js do
  end
  
  new_action.before do
    object.beers.build
  end
  
  show.wants.json do
    render :json => object.to_json(:methods => :slug)
  end 

  create.flash "Thanks, The pub has been added"
  
  
  private
  def which_layout?
    params[:action] == 'index' ? 'two_column' : 'one_column'
  end
  
  def collection      
    if params[:format] == 'json'
      #get all pubs with minimal details
      end_of_association_chain.all_optimised_for_cluster_for_map
    elsif params[:format] == 'js'
      #get details for a limited amount of pubs. but full details
      end_of_association_chain.within_boundreys(params[:min_lat], params[:max_lat], params[:min_lng], params[:max_lng])
    else
      end_of_association_chain.find(:all)
    end
 #end_of_association_chain.find(:all, :limit => 10)
  end
  
end
