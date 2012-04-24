class UsersController < ApplicationController
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      user = login(params[:user][:email], params[:user][:password], false)
      if user
        flash[:success] = 'Successfully signed up for EmployTown!'
        redirect_back_or_to home_url_for(@user)
      else
        flash[:error] = "There was a problem signing you up. Try filling out the signup form again."
        redirect_to root_url
      end
    else
      render :new
    end
  end
end
