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
    
  end
end

privileges do
  privilege :manage, :includes => [:create, :read, :update, :delete, :show]
  privilege :read, :includes => [:index, :show]
  privilege :create, :includes => :new
  privilege :update, :includes => [:edit]
  privilege :delete, :includes => :destroy
  privilege :add_caregiver, :includes => :add_caregiver
  privilege :hide, :includes => [:hide_request, :hide_all_by_household]
  privilege :search, :includes => :search
  privilege :delete_account, :includes => :delete_account
end