class HomeController < ApplicationController
  before_filter :require_login, :only => :secret
  before_filter :require_user_url, :only => :seekers_public_profile
  
  #filter_access_to :all
  
  def index
    
  end

  def seekers_public_profile
    @user = User.find_by_user_url(params[:user_url])
  end

  private

    def require_user_url
      if User.find_by_user_url(params[:user_url]).eql? nil
        redirect_to error_path
      end
    end
end