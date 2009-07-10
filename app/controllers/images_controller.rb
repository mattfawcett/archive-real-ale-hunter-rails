class ImagesController < ResourceController::Base
  actions :all, :execpt => [:destroy, :edit, :update]
  belongs_to :pub
  
  layout "two_column"
  
  create.flash "Thanks, your photo has been uploaded"
  create.wants.html { redirect_to pub_images_path(parent_object) }
  create.before do
    object.user = User.first
  end
end