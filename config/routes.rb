EmployTown::Application.routes.draw do

  match 'error' => 'home#error'

  get "search/search"

  root :to => "home#index"


  
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
    match 'users/:user_url/edit' => 'users#edit'
    resources :biddings
    resources :companies
    resources :users
    resources :seekers
    resources :search, :to => "search#index"
    root :to => "employers#index"
  end
  
  namespace :seekers do
    match '/users/:user_url/edit' => 'users#edit'
    resources :tags
    resources :biddings do
      get 'interested', :on => :member
      get 'not_interested', :on => :member
    end
    resources :companies, :only => [:show]
    resources :users, :only => [:edit, :show, :update]
    root :to => "seekers#index"
  end

  get '/:user_url' => 'home#seekers_public_profile'

end
