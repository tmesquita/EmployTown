EmployTown::Application.routes.draw do

  match 'error' => 'home#error'

  get "search/search"

  root :to => "home#index"
  get "about_us" => "home#about_us"

  
  get "sessions/new"

  get "users/new"
  
  get "logout" => "sessions#destroy", :as => "logout"
  get "login" => "sessions#new", :as => "login"
  get "signup" => "users#new", :as => "signup"

  
  
  resources :users
  resources :sessions
  resources :home
  resources :biddings
  resources :companies

  
  namespace :administrators do
    resources :users
  end
  
  namespace :employers do
    resources :biddings
    resources :companies
    resources :users
    resources :seekers
    resources :search, :to => "search#index"
    root :to => "employers#index"
  end
  
  namespace :seekers do
    
    resources :tags
    resources :biddings do
      get 'interested', :on => :member
      get 'not_interested', :on => :member
    end
    resources :companies, :only => [:show]
    resources :users, :only => [:edit, :show, :update]
    get '/info/:id/edit' => 'seekers#edit', :as => 'edit_info'
    match '/users/:id/update' => 'seekers#update'
    match '/users/:id/enable_facebook' => 'seekers#enable_facebook', :as => 'enable_facebook'
    match '/users/:id/disable_facebook' => 'seekers#disable_facebook', :as => 'disable_facebook'
    match '/users/:id/enable_twitter' => 'seekers#enable_twitter', :as => 'enable_twitter'
    match '/users/:id/disable_twitter' => 'seekers#disable_twitter', :as => 'disable_twitter'
    match '/users/:id/enable_blog' => 'seekers#enable_blog', :as => 'enable_blog'
    match '/users/:id/disable_blog' => 'seekers#disable_blog', :as => 'disable_blog'
    root :to => "seekers#index"
  end

  get '/:user_url' => 'home#seekers_public_profile'

end
