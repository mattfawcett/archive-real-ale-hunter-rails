class PubsController < ResourceController::Base
  layout :which_layout?
  
  index.wants.json do
    render :json => Pub.for_map.to_json
  end 
  
  new_action.before do
    object.beers.build
  end

  create.flash "Thanks, The pub has been added"
  
  
  private
  def which_layout?
    params[:action] == 'index' ? 'two_column' : 'one_column'
  end
end
