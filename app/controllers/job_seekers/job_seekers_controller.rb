class JobSeekers::JobSeekersController < ApplicationController
  layout 'admin'
  before_filter :require_login, :get_user
  before_filter :get_request_path, :only => [:edit, :edit_profile]
  
  def index
    @bids = current_user.bids

    @not_responded_bids_count = @bids.not_responded.count
    @interested_bids_count = @bids.interested.count
    @not_interested_bids_count = @bids.not_interested.count

    @bids = @bids.not_responded.paginate(:page => params[:page], :per_page => 2).order('created_at DESC')

    @tags = Tag.find_all_by_user_id(current_user.id)
    @tag = Tag.new

    flash.now[:info] = "You have no new bids. You may want to work on your <a href='#{job_seekers_edit_profile_path}'>profile</a> to attract more employers".html_safe if current_user.bids.not_responded.count < 1
  end

  def update
    action = session[:return_to].split('/').last

    if @user.update_attributes(params[:job_seeker])
      flash[:success] = "Your profile was sucessfully updated."
      redirect_to session[:return_to]
    else
      flash.now[:error] = @user.errors.full_messages
      render action
    end
  end

  def enable_media
    if @user.update_attributes(params[:social_flag] => true)
      redirect_to job_seekers_edit_info_path
    else
      render :edit_profile
    end
  end

  def disable_media
    if @user.update_attributes(params[:social_flag] => false)
      redirect_to job_seekers_edit_info_path
    else
      render :edit_profile
    end
  end
  
  protected

    def permission_denied
      flash[:error] = "You do not have access to #{request.path}."
      if current_user
        redirect_to root_path
      else
        flash[:error] = 'Please log in to view that page'
        redirect_to login_path
      end
    end

  private

    def get_user
      @user = current_user
    end

    def get_request_path
      session[:return_to] = request.path
    end
end