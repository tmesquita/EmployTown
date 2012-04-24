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
    match '/biddings/interested_bids' => 'biddings#interested_bids', :as => 'interested_bids'
    match '/biddings/uninterested_bids' => 'biddings#uninterested_bids', :as => 'uninterested_bids'
    resources :biddings
    resources :companies
    resources :users
    resources :seekers
    resources :search, :to => "search#index"
    root :to => "employers#index"
    #match '/companies/edit' => 'companies#edit', :as => 'edit_company'
    #match '/companies/update' => 'companies#update', :as => 'update'
    match '/companies/:id/enable_facebook' => 'companies#enable_facebook', :as => 'enable_facebook'
    match '/companies/:id/disable_facebook' => 'companies#disable_facebook', :as => 'disable_facebook'
    match '/companies/:id/enable_twitter' => 'companies#enable_twitter', :as => 'enable_twitter'
    match '/companies/:id/disable_twitter' => 'companies#disable_twitter', :as => 'disable_twitter'
    match '/companies/:id/enable_blog' => 'companies#enable_blog', :as => 'enable_blog'
    match '/companies/:id/disable_blog' => 'companies#disable_blog', :as => 'disable_blog'
    #match '/companies/enable_facebook' => 'companies#enable_facebook', :as => 'enable_facebook'
    #match '/companies/disable_facebook' => 'companies#disable_facebook', :as => 'disable_facebook'
    #match '/companies/enable_twitter' => 'companies#enable_twitter', :as => 'enable_twitter'
    #match '/companies/disable_twitter' => 'companies#disable_twitter', :as => 'disable_twitter'
    #match '/companies/enable_blog' => 'companies#enable_blog', :as => 'enable_blog'
    #match '/companies/disable_blog' => 'companies#disable_blog', :as => 'disable_blog'
    match '/:user_url', :to => redirect {|params| "/#{params[:user_url]}"}
  end
  
  namespace :seekers do
    
    resources :tags
    match '/biddings/interested_bids' => 'biddings#interested_bids', :as => 'interested_bids'
    match '/biddings/uninterested_bids' => 'biddings#uninterested_bids', :as => 'uninterested_bids'
    resources :biddings do
      get 'interested', :on => :member
      get 'not_interested', :on => :member
    end
    resources :companies, :only => [:show]
    resource :user, :only => [:edit, :show, :update]
    #get '/info/edit' => 'seekers#edit', :as => 'edit_info'
    #match '/users/edit', 'seekers#edit', :as => 'edit'
    match '/info/edit' => 'seekers#edit', :as => 'edit_info'
    match '/info/update' => 'seekers#update', :as => 'update'
    #match '/users/:id/enable_facebook' => 'seekers#enable_facebook', :as => 'enable_facebook'
    match '/users/enable_facebook' => 'seekers#enable_facebook', :as => 'enable_facebook'
    #match '/users/:id/disable_facebook' => 'seekers#disable_facebook', :as => 'disable_facebook'
    match '/users/disable_facebook' => 'seekers#disable_facebook', :as => 'disable_facebook'
    #match '/users/:id/enable_twitter' => 'seekers#enable_twitter', :as => 'enable_twitter'
    match '/users/enable_twitter' => 'seekers#enable_twitter', :as => 'enable_twitter'
    #match '/users/:id/disable_twitter' => 'seekers#disable_twitter', :as => 'disable_twitter'
    match '/users/disable_twitter' => 'seekers#disable_twitter', :as => 'disable_twitter'
    #match '/users/:id/enable_blog' => 'seekers#enable_blog', :as => 'enable_blog'
    match '/users/enable_blog' => 'seekers#enable_blog', :as => 'enable_blog'
    #match '/users/:id/disable_blog' => 'seekers#disable_blog', :as => 'disable_blog'
    match '/users/disable_blog' => 'seekers#disable_blog', :as => 'disable_blog'
    match '/profile' => 'seekers#profile', :as => 'profile'
    match '/:user_url', :to => redirect {|params| "/#{params[:user_url]}"} 
    root :to => "seekers#index"
  end

  get '/:user_url' => 'home#seekers_public_profile'

end
