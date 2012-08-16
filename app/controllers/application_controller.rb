class ApplicationController < ActionController::Base
  helper_method :home_url_for
  helper :url
  protect_from_forgery
  
  protected

    def not_authenticated
      flash[:error] = "First login to access this page"
      redirect_to login_url
    end
  
    def home_url_for(user)
      return root_url if user.nil?
      return employers_root_path if user.is_employer?
      job_seekers_root_path
    end
    
    def permission_denied
      flash[:error] = "Sorry, you are not allowed to access that page."
      redirect_to login_path
    end
end