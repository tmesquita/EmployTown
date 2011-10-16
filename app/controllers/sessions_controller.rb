class SessionsController < ApplicationController
  def create
    user = login(params[:email], params[:password], params[:remember_me])
      if user
        #flash[:success] = "You have logged in!"
        redirect_back_or_to home_url_for(user)
      else
        flash.now.alert = "Email or password was invalid"
        render :new
      end
  end
  
  def destroy
    logout
      #flash[:error] = "Logged out!"
      redirect_to root_url 
  end

end
