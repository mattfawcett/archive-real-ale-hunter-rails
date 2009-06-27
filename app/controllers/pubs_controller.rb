class PubsController < ResourceController::Base
  layout :which_layout?
  
  new_action.before do
    object.beers.build
  end

  
  create.flash "Thanks, Mr Foleys has been added"
  

  private
  def which_layout?
    params[:action] == 'index' ? 'two_column' : 'one_column'
  end
end
