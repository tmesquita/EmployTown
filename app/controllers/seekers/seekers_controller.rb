class Seekers::SeekersController < ApplicationController
  filter_access_to :all
  
  def index
    @user = current_user
    @bids = Bidding.where(:seeker_id => current_user.id, :interested => nil).paginate(:page => params[:page], :per_page => 2).order('created_at DESC')

    @tags = Tag.find_all_by_user_id(current_user.id)
    @tag = Tag.new
  end

  def edit
    #@user = User.find(params[:id])
    @user = current_user
  end

  def profile
    @user = current_user
  end

  def update
    #@user = User.find(params[:id])
    @user = current_user

    if @user.update_attributes(params[:user])
      flash[:success] = "Your profile was sucessfully updated."
      redirect_to(seekers_edit_info_path)
    else
      render :action => "edit"
    end
  end

  def enable_facebook
    #@user = User.find(params[:id])
    @user = current_user
    @user.facebook_enabled_flag = true
    respond_to do |format|
      if @user.save
        format.html { redirect_to seekers_edit_info_path }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  def disable_facebook
    #@user = User.find(params[:id])
    @user = current_user
    @user.facebook_enabled_flag = false
    respond_to do |format|
      if @user.save
        format.html { redirect_to seekers_edit_info_path }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  def enable_twitter
    #@user = User.find(params[:id])
    @user = current_user
    @user.twitter_enabled_flag = true
    respond_to do |format|
      if @user.save
        format.html { redirect_to seekers_edit_info_path }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  def disable_twitter
    #@user = User.find(params[:id])
    @user = current_user
    @user.twitter_enabled_flag = false
    respond_to do |format|
      if @user.save
        format.html { redirect_to seekers_edit_info_path }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  def enable_blog
    #@user = User.find(params[:id])
    @user = current_user
    @user.blog_enabled_flag = true
    respond_to do |format|
      if @user.save
        format.html { redirect_to seekers_edit_info_path }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  def disable_blog
    #@user = User.find(params[:id])
    @user = current_user
    @user.blog_enabled_flag = false
    respond_to do |format|
      if @user.save
        format.html { redirect_to seekers_edit_info_path }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
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
        flash[:error] = 'Please log in to view that page'
        redirect_to login_path
      end
    end
end