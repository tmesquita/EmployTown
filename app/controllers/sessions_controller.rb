class SessionsController < ApplicationController
  def create
    user = login(params[:email], params[:password], params[:remember_me])
    if user
      redirect_back_or_to home_url_for(user)
    else
      flash[:error] = "Email or password was invalid"
      render :new
    end
  end
  
  def destroy
    logout
    redirect_to root_url 
  end

end
