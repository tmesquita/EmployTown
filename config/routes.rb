EmployTown::Application.routes.draw do
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
    resources :users
  end
  
  namespace :seekers do
    resources :tags
    resources :biddings
    resources :users, :only => [:edit, :show, :update]
    #root :controller => "seekers", :action => "index"
    root :to => "seekers#index"
  end
end
