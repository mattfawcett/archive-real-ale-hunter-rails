class PubsController < ResourceController::Base
  create.after do
    flash[:notice] = "Thanks, Mr Foleys has been added"
  end

end
