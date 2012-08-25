class Employers::EmployersController < ApplicationController
  layout 'admin'
  before_filter :require_login
  before_filter :get_user
  
  def index
    @bids = current_user.bids.interested.paginate(:page => params[:page], :per_page => 2).order('updated_at DESC')
    flash.now[:error] = "You are currently not associated with a company. Please <a href='#{new_employers_company_path}'>update</a> your company info. You will not be allowed to bid on any potential employees until your company is created".html_safe if current_user.company.nil?
  end

  def update
    if @user.update_attributes(params[:employer])
      flash[:success] = 'Information has been successfully updated.'
      redirect_to employers_edit_path
    else
      render :action => "edit"
    end
  end
  
  protected

    def get_user
      @user = current_user
    end

    def permission_denied
      flash[:error] = "You do not have access to #{request.path}."
      if current_user
        redirect_to home_url_for(current_user)
      else
        flash[:error] = 'Please log in to view this page'
        redirect_back_or_to login_path
      end
    end
end