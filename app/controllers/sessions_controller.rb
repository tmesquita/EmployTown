class SessionsController < ApplicationController
  def create
    user = login(params[:email], params[:password], params[:remember_me])
    if user
      flash[:info] = "You have no new bids. You may want to work on your <a href='#{job_seekers_edit_profile_path}'>profile</a> to attract more employers".html_safe if user.bids.not_responded.count < 1 && user.is_job_seeker?
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
