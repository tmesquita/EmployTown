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
    resources :companies
    resources :users
    root :to => "employers#index"
  end
  
  namespace :seekers do
    resources :tags
    resources :biddings
    resources :users, :only => [:edit, :show, :update]
    root :to => "seekers#index"
  end
end
