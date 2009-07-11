class PubsController < ResourceController::Base
  layout :which_layout?
  
  index.wants.json do
    render :json => collection.to_json
  end 
  
  new_action.before do
    object.beers.build
  end
  
  show.wants.json do
    render :json => object.to_json
  end 

  create.flash "Thanks, The pub has been added"
  
  
  private
  def which_layout?
    params[:action] == 'index' ? 'two_column' : 'one_column'
  end
  
  def collection      
    if params[:format] == 'json'
      end_of_association_chain.all_optimised_for_cluster_for_map
    else
      end_of_association_chain.find(:all)
    end
  end
  
end
