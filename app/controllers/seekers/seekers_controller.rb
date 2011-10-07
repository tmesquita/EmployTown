class Seekers::SeekersController < ApplicationController
  filter_access_to :all
  
  def index
    @user = current_user
  end
  
  protected

    def permission_denied
      flash[:error] = "You do not have access to #{request.path}."
      respond_to do |format|
        format.html { 
          if current_user.is_seeker?
            redirect_to seekers_root_url
          elsif current_user.is_employer?
            redirect_to employers_root_url
          else
            redirect_ot root_url
          end
          }
        format.xml { head :unauthorized }
        format.js { head :unauthorized }
      end
    end
end