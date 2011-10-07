authorization do
  role :administrator do
    
  end
  
  role :developer do
    includes :administrator
    
  end
  
  role :seeker do
    has_permission_on :seekers_users, :to => :update
    has_permission_on :seekers_tags, :to => :manage
    has_permission_on :seekers_seekers, :to => :manage
    has_permission_on :seekers_biddings, :to => :manage
  end
  
  role :employer do
    has_permission_on :employers_users, :to => :update
    has_permission_on :employers_biddings, :to => :manage
    has_permission_on :employers_companies, :to => :manage
    has_permission_on :employers_employers, :to => :manage
  end
end

privileges do
  privilege :manage, :includes => [:create, :read, :update, :delete, :show]
  privilege :read, :includes => [:index, :show]
  privilege :create, :includes => :new
  privilege :update, :includes => [:edit]
  privilege :delete, :includes => :destroy
end