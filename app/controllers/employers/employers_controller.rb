class Employers::EmployersController < ApplicationController
  filter_access_to :all
  
  def index
    
  end
  
  protected

    def permission_denied
      flash[:error] = "You do not have access to #{request.path}."
      if current_user
        respond_to do |format|
          format.html { 
            if current_user.is_seeker? 
              redirect_to seekers_root_url
            elsif current_user.is_employer?
              redirect_to employers_root_url
            else
              redirect_to root_url
            end
            }
          format.xml { head :unauthorized }
          format.js { head :unauthorized }
        end
      else
        flash[:error] = 'Please log in to view this page'
        redirect_to login_path
      end
    end
end