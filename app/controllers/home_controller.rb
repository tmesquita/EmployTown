class HomeController < ApplicationController
  before_filter :require_login, :only => :secret
  before_filter :require_user_url, :only => :job_seekers_public_profile
  
  def index
    redirect_to home_url_for(current_user) if current_user
  end

  def job_seekers_public_profile
    @user = User.find_by_user_url(params[:user_url])
  end

  private

    def require_user_url
      if User.find_by_user_url(params[:user_url]).eql? nil
        redirect_to error_path
      end
    end
end