Employtown::Application.routes.draw do
  get "search/search"

  root :to => "home#index"

  get "about_us" => "home#about_us"
  
  get "logout" => "sessions#destroy", :as => "logout"
  get "login" => "sessions#new", :as => "login"
  get "signup" => "users#new", :as => "signup"

  resources :sessions

  namespace :job_seekers do
    resource :job_seeker, :only => [:show, :update]
    resources :bids, :only => :none do
      get :accept
      get :decline
    end
    controller :job_seekers do
      get :edit_profile
      get :profile
      get :edit
    end
    root :to => "job_seekers#index"
  end
  
  namespace :employers do
    resource :employer, :only => [:show, :update]
    resources :job_seekers, :only => :none do
      resources :bids, :only => [:new, :create]
    end
    resources :bids, :except => :new
    controller :employers do
      get :edit
    end
    resource :company, :except => :destroy
    match '/search', :to => "search#index"
    root :to => "employers#index"
  end

  resources :users, :path => '/', :only => :show
end
