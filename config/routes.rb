ActionController::Routing::Routes.draw do |map|
  map.resources :pubs, :shallow => true, :has_many => [:images, :visits, :ratings]
  map.resource :map
  map.resources :towns, :has_many => :pubs

  map.root :controller => 'pages'

  
  map.connect ':action', :controller => 'pages'
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
  
end
