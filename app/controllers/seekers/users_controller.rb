class Seekers::UsersController < Seekers::SeekersController
  def edit
    #@user = User.find(params[:id])
    @user = current_user
  end
  
  def show
    @user = User.find_by_user_url(params[:user_url])
  end
  
  def update
    #@user = User.find(params[:id])
    @user = current_user

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to(edit_seekers_user_path, :notice => 'User was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  

  #def update_attributes
  #  @user = User.find(params[:id])
  #
  #  respond_to do |format|
  #    if @user.update_attributes(params[:user])
  #      format.html { redirect_to(seekers_edit_info_path(@user), :notice => 'User was successfully updated.') }
  #      format.sml { head :ok}
  #    else
  #      format.html { render :action => "edit" }
  #      format.xml { render :xml => @user.errors, :status => :unprocessable_entity }
  #    end
  #  end
  #end
end
