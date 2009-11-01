class ImagesController < ResourceController::Base
  before_filter :require_login, :only => [:new, :create]
  before_filter :redirect_to_best_pub_id, :only => [:index]
  actions :all, :except => [:destroy, :edit, :update]
  belongs_to :pub

  
  create.flash "Thanks, your photo has been uploaded"
  create.wants.html { redirect_to pub_images_path(parent_object) }
  create.before do
    object.user = @current_user
  end
  
  private
  def redirect_to_best_pub_id
    redirect_to pub_images_path(parent_object), :status => 301 if parent_object.has_better_id? 
  end
end
