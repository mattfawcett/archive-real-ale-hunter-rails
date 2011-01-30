ActionController::Routing::Routes.draw do |map|
  map.resources :pubs, :shallow => true, :has_many => [:images, :visits, :ratings]
  map.resource :map
  map.resources :searches
  map.resources :towns, :has_many => :pubs
  map.resources :users
  map.root :controller => 'pages'
  
  map.namespace :api do |api|
    api.resources :pubs, :collection => {:search => :get, :closest => :get}, :has_many => [:images]
  end

  map.logout "/logout", :controller => "pages", :action => "logout"  
    
  map.connect ':action', :controller => 'pages'
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
  
end
