class Seekers::UsersController < Seekers::SeekersController
  
  def edit
    @user = current_user
  end
  
  def update
    @user = current_user

    if @user.update_attributes(params[:user])
      flash[:success] = 'User was successfully updated'
      redirect_to edit_seekers_user_path
    else
      format.html { render :action => "edit" }
    end
  end
end
