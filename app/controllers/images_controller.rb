class ImagesController < ResourceController::Base
  before_filter :require_login, :only => [:new, :create]
  actions :all, :except => [:destroy, :edit, :update]
  belongs_to :pub

  
  create.flash "Thanks, your photo has been uploaded"
  create.wants.html { redirect_to pub_images_path(parent_object) }
  create.before do
    object.user = @current_user
  end
end
