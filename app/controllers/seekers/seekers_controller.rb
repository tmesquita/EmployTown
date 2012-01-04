class Seekers::SeekersController < ApplicationController
  filter_access_to :all
  
  def index
    @user = current_user
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    # Current user being updated
    @user = User.find(params[:id])

    # Check to see if user with the url of the user_url post parameter exists
    @user_exists = User.find_by_user_url(params[:user][:user_url])

    # if a record exists and doesn't match current user, throw an error
    # and checks to make sure the url contains alpha-numeric values 
    if (@user_exists && @user_exists != @user) || !(params[:user][:user_url].to_s.match(/[^\w]/).eql?(nil))
      if !params[:user][:user_url].to_s.match(/[^\w]/).eql? nil
        flash[:notice] = 'URL is invalid. Must be an alpha-numeric character.'
        redirect_to seekers_edit_info_path(@user)
      else      
        flash[:notice] = 'URL is already taken!'
        redirect_to seekers_edit_info_path(@user)
      end
    else
      if @user.update_attributes(params[:user])
        flash[:notice] = "Your profile was sucessfully updated."
        redirect_to(seekers_edit_info_path(@user))
      else
        render :action => "edit"
      end   
    end 
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