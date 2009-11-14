class VisitsController < ResourceController::Base
  actions :all, :except => [:destroy, :edit, :update]
  belongs_to :pub
  
  layout "one_column"

  new_action.before do
    object.beers.build
  end

  
  create.flash "Thanks, your visit has been added"
  create.wants.html { redirect_to pub_path(parent_object) }
  create.before do
    object.user = @current_user
  end
end
