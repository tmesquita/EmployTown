EmployTown::Application.routes.draw do
  get "search/search"

  root :controller => "home", :action => "index"
  
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
    resources :biddings
    #match "biddings/:id/interested", "biddings#interested", :as => "interested_seekers_bidding" 
    resources :companies, :only => [:show]
    resources :users, :only => [:edit, :show, :update]
    root :to => "seekers#index"
  end
end
