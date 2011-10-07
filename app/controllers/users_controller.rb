class UsersController < ApplicationController
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
<<<<<<< HEAD
      flash[:notice] = "Signed up!"
      redirect_to root_url
=======
      user = login(params[:user][:email], params[:user][:password], false)
      if user
        redirect_back_or_to seekers_root_url, :notice => "Successfully signed up for EmployTown!"
      else
        flash.now.alert = "There was a problem signing you up. Try filling out the signup form again."
        redirect_to root_url
      end
>>>>>>> a8c8663387b18f3d11f879d16634598629025dae
    else
      render :new
    end
  end
end
