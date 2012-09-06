RealAleHunter::Application.routes.draw do
  devise_for :users

  resources :pubs do
    resources :ratings
    resources :images
    resources :visits
    member do
      get :map_marker_html
    end
  end
  resource :map
  resources :searches
  resources :towns do
    resources :pubs
  end
  resources :users
  match '/' => 'pages#index', :as => "root"
  namespace :api do
    resources :pubs do
      collection do
        get :search
        get :closest
      end
      resources :images
    end
  end

  match "/whats_new" => "pages#whats_new", :as => :whats_new
  match "/what_is_real_ale" => "pages#what_is_real_ale", :as => :what_is_real_ale
  match "/styles_of_real_ale" => "pages#styles_of_real_ale", :as => :styles_of_real_ale
  match "/brewing_real_ale" => "pages#brewing_real_ale", :as => :brewing_real_ale
  match "/camra_campaign_for_real_ale" => "pages#camra_campaign_for_real_ale", :as => :camra_campaign_for_real_ale
  match "/links" => "pages#links", :as => :links
end

