authorization do
  role :administrator do
    
  end
  
  role :developer do
    includes :administrator
    
  end
  
  role :seeker do
    has_permission_on :seekers_users, :to => :update
    has_permission_on :seekers_tags, :to => :manage
    has_permission_on :seekers_seekers, :to => [:manage, :enable_disable_social_media]
    has_permission_on :seekers_biddings, :to => [:manage, :interested, :not_interested]
    has_permission_on :seekers_companies, :to => :read
  end
  
  role :employer do
    has_permission_on :employers_users, :to => :update
    has_permission_on :employers_biddings, :to => :manage
    has_permission_on :employers_companies, :to => :manage
    has_permission_on :employers_employers, :to => :manage
    has_permission_on :employers_search, :to => :read
    has_permission_on :employers_seekers, :to => :read
  end
end

privileges do
  privilege :manage, :includes => [:create, :read, :update, :delete, :show, :update_stuff]
  privilege :enable_disable_social_media, :includes => [:enable_facebook, :enable_twitter, :enable_blog, :disable_facebook, :disable_twitter, :disable_blog]
  privilege :read, :includes => [:index, :show]
  privilege :create, :includes => :new
  privilege :update, :includes => [:edit]
  privilege :delete, :includes => :destroy
end