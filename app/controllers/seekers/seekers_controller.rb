class Seekers::SeekersController < ApplicationController
  filter_access_to :all
  
  def index
    @user = current_user
    @bids = current_user.get_my_biddings

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
    # Current user being updated
    #@user = User.find(params[:id])
    @user = current_user

    # Check to see if user with the url of the user_url post parameter exists
    @user_exists = User.find_by_user_url(params[:user][:user_url])

    # if a record exists and doesn't match current user, throw an error
    # and checks to make sure the url contains alpha-numeric values 
    if (@user_exists && @user_exists != @user) || !(params[:user][:user_url].to_s.match(/[^\w]/).eql?(nil))
      if !params[:user][:user_url].to_s.match(/[^\w]/).eql? nil
        flash[:notice] = 'URL is invalid. Must be an alpha-numeric character.'
        redirect_to seekers_edit_info_path
      else      
        flash[:notice] = 'URL is already taken!'
        redirect_to seekers_edit_info_path
      end
    else
      if @user.update_attributes(params[:user])
        flash[:notice] = "Your profile was sucessfully updated."
        redirect_to(seekers_edit_info_path)
      else
        render :action => "edit"
      end   
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