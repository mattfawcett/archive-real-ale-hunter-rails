RealAleHunter::Application.routes.draw do
  resources :pubs
  resource :map
  resources :searches
  resources :towns
  resources :users
  match '/' => 'pages#index', :as => "root"
  namespace :api do
      resources :pubs do
        collection do
    get :search
    get :closest
    end
    end
  end

  match '/logout' => 'pages#logout', :as => :logout
  match ':action' => 'pages#index'
  match '/:controller(/:action(/:id))'
end

