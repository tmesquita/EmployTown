Employtown::Application.routes.draw do
  root :to => "home#index"
  
  get "logout" => "sessions#destroy", :as => "logout"
  get "login" => "sessions#new", :as => "login"
  get "signup" => "users#new", :as => "signup"
  resources :users, :only => [:create, :new]
  resources :sessions

  namespace :job_seekers do
    resource :job_seeker, :only => :update
    controller :job_seekers do
      get :edit_profile
      get :edit
    end
    resources :bids, :only => :show do
      get :accept
      get :decline
    end
    resources :companies, :only => :show
    root :to => "job_seekers#index"
  end
  
  namespace :employers do
    resource :employer, :only => :update
    controller :employers do
      get :edit
    end
    resources :job_seekers, :only => :none do
      resources :bids, :only => [:new, :create]
    end
    resources :bids, :only => :destroy
    resource :company, :except => [:destroy, :show]
    match '/search', :to => "search#index"
    root :to => "employers#index"
  end

  resources :users, :path => '/', :only => :show
end
