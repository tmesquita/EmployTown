class JobSeekers::JobSeekersController < ApplicationController
  layout 'admin'
  before_filter :require_login, :get_user
  before_filter :get_request_path, :only => [:edit, :edit_profile]
  helper_method :bid_filter
  
  def index
    @bids = current_user.bids

    case bid_filter
    when 'not_responded' then @bids = @bids.not_responded
    when 'accepted' then @bids = @bids.interested
    when 'declined' then @bids = @bids.not_interested
    end

    @bids = @bids.order('created_at DESC')
    @bids = BidDecorator.decorate(@bids)
  end

  def update
    action = session[:return_to].split('/').last

    if params[:tags]
      @user.tags.destroy_all
      @user.tags = params[:tags].split(',').map(&:strip).uniq.map{ |tag_name| Tag.new(name: tag_name, user: current_user) }
      @user.save
    end

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

    def bid_filter
      params[:filter] unless params[:filter].blank?
    end

    def get_user
      @user = current_user
    end

    def get_request_path
      session[:return_to] = request.path
    end
end