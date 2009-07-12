ActionController::Routing::Routes.draw do |map|
  map.resources :pubs, :has_many => [:images, :visits]
  map.resource :map

  map.root :controller => 'pages'

  
  map.connect ':action', :controller => 'pages'
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
  
end
