class ApplicationController < ActionController::Base
  helper_method :home_url_for
  protect_from_forgery
  
  def not_authenticated
    redirect_to login_url, :alert => "First login to access this page."
  end
  
  protected
  
    def home_url_for(user)
      return root_url if user.nil?
      user.is_employer? ? employers_root_url : seekers_root_url
    end
    
    def permission_denied
      flash[:error] = "Sorry, you are not allowed to access that page."
      redirect_to root_url
    end
end