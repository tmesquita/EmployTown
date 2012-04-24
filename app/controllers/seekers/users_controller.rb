class Seekers::UsersController < Seekers::SeekersController
  
  def edit
    @user = current_user
  end
  
  #def show
  #  @user = User.find_by_user_url(params[:user_url])
  #end
  
  def update
    @user = current_user

    respond_to do |format|
      if @user.update_attributes(params[:user])
        flash[:success] = 'User was successfully updated'
        format.html { redirect_to(edit_seekers_user_path) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end
end
