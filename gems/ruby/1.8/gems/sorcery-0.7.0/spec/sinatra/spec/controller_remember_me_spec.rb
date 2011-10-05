require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Sinatra::Application do
  
  # ----------------- REMEMBER ME -----------------------
  describe Sinatra::Application, "with remember me features" do
    before(:all) do
      ActiveRecord::Migrator.migrate("#{APP_ROOT}/db/migrate/remember_me")
      sorcery_reload!([:remember_me])
    end
    
    before(:each) do
      create_new_user
    end
    
    after(:all) do
      ActiveRecord::Migrator.rollback("#{APP_ROOT}/db/migrate/remember_me")
    end
    
    after(:each) do
      session = nil
      clear_cookies
      User.delete_all
    end
    
    it "should set cookie on remember_me!" do
      post "/test_login_with_remember", :username => 'gizmo', :password => 'secret'
      cookies["remember_me_token"].should == assigns[:user].remember_me_token
    end
    
    it "should clear cookie on forget_me!" do
      cookies["remember_me_token"] == {:value => 'asd54234dsfsd43534', :expires => 3600}
      get '/test_logout'
      cookies["remember_me_token"].should == nil
    end
    
    it "login(username,password,remember_me) should login and remember" do
      post '/test_login_with_remember_in_login', :username => 'gizmo', :password => 'secret', :remember => "1"
      cookies["remember_me_token"].should_not be_nil
      cookies["remember_me_token"].should == assigns[:user].remember_me_token
    end
    
    it "logout should also forget_me!" do
      session[:user_id] = @user.id
      get '/test_logout_with_remember'
      cookies["remember_me_token"].should == nil
    end
    
    it "should login_from_cookie" do
      post "/test_login_with_remember", :username => 'gizmo', :password => 'secret'
      get_sinatra_app(subject).instance_eval do
        @current_user = nil
      end
      session[:user_id] = nil
      get '/test_login_from_cookie'
      assigns[:current_user].should == @user
    end
    
    it "should not remember_me! when not asked to" do
      post '/test_login', :username => 'gizmo', :password => 'secret'
      cookies["remember_me_token"].should == nil
    end
  end
end