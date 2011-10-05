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
  
  namespace :administrators do
    resources :users
  end
  
  namespace :employers do
    resources :biddings
    resources :users
  end
  
  namespace :seekers do
    resources :tags
    resources :users
  end
end
