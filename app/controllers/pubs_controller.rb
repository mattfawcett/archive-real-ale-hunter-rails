class PubsController < ResourceController::Base
  layout :which_layout?
  
  create.flash "Thanks, Mr Foleys has been added"
  

  private
  def which_layout?
    params[:action] == 'show' ? 'one_column' : 'two_column'
  end
end
