class Employers::EmployersController < ApplicationController
  filter_access_to :all
  before_filter :require_login
  
  def index
    @user = current_user
    @bids = Bidding.where(:employer_id => current_user.id, :interested => true).paginate(:page => params[:page], :per_page => 2).order('updated_at DESC')
  end
  
  protected

    def permission_denied
      flash[:error] = "You do not have access to #{request.path}."
      if current_user
        respond_to do |format|
          format.html { 
            #if current_user.is_seeker? 
            #  redirect_to seekers_root_url
            #elsif current_user.is_employer?
            #  redirect_to employers_root_url
            #else
            #  redirect_to root_url
            #end
            redirect_to home_url_for(current_user)
            }
          format.xml { head :unauthorized }
          format.js { head :unauthorized }
        end
      else
        flash[:error] = 'Please log in to view this page'
        redirect_back_or_to login_path
      end
    end
end