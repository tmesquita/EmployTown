Employtown::Application.routes.draw do
  get "search/search"

  root :to => "home#index"

  get "about_us" => "home#about_us"

  get "users/new"
  
  get "logout" => "sessions#destroy", :as => "logout"
  get "login" => "sessions#new", :as => "login"
  get "signup" => "users#new", :as => "signup"

  resources :users
  resources :sessions

  namespace :job_seekers do
    resource :job_seeker, :only => [:show, :update]
    resources :tags, :except => [:index, :show]
    resources :bids, :only => :index do
      get :interested, :on => :member
      get :not_interested, :on => :member
      get :interested_bids, :on => :collection
      get :uninterested_bids, :on => :collection
    end
    controller :job_seekers do
      get :edit_profile
      get :profile
      get :edit
      get :enable_media
      get :disable_media
    end
    match '/:user_url', :to => redirect { |params| "/#{params[:user_url]}" }
    root :to => "job_seekers#index"
  end
  
  namespace :employers do
    resource :employer, :only => [:show, :update]
    resources :job_seekers do
      resources :bids, :only => [:new, :create, :destroy]
    end
    resources :bids, :only => :index do
      get :interested, :on => :collection
      get :not_interested, :on => :collection
    end
    controller :employers do
      get :edit
    end
    resource :company do
      get :enable_media
      get :disable_media
    end
    # resources :seekers, :only => [:index, :edit, :update]
    match '/search', :to => "search#index"
    match '/:user_url', :to => redirect {|params| "/#{params[:user_url]}"}
    root :to => "employers#index"
  end

  # resources :users
  # resources :sessions
  # resources :home
  # resources :biddings
  # resources :companies

  
  # namespace :administrators do
  #   resources :users
  # end
  
  # namespace :seekers do
  
  #   match '/biddings/interested_bids' => 'biddings#interested_bids', :as => 'interested_bids'
  #   match '/biddings/uninterested_bids' => 'biddings#uninterested_bids', :as => 'uninterested_bids'
  #   resources :biddings, :only => [:index] do
  #     get 'interested', :on => :member
  #     get 'not_interested', :on => :member
  #   end
  #   #resources :companies, :only => [:show]
  #   resource :user, :only => [:edit, :show, :update]
  #   match '/info/update' => 'seekers#update', :as => 'update'
  #   match '/:user_url', :to => redirect {|params| "/#{params[:user_url]}"} 
  #   root :to => "seekers#index"
  # end

  match 'error' => 'home#error'
  get '/:user_url' => 'home#job_seekers_public_profile'
end
