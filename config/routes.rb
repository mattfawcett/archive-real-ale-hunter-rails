ActionController::Routing::Routes.draw do |map|
  map.resources :pubs, :has_many => :images


  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
