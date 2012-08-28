class UsersController < ApplicationController
  layout :get_layout, :only => :show

  def new
    @user = User.new
  end

  def show
    @user = User.find_by_user_url(params[:id])
    @user = UserDecorator.decorate(@user)
    redirect_to '/404' unless @user
  end
  
  def create
    @user = Employer.new(params[:user]) if params[:role].eql? 'employer'
    @user = JobSeeker.new(params[:user]) if params[:role].eql? 'job_seeker'

    if @user.save
      user = login(params[:user][:email], params[:user][:password], false)
      if user
        flash[:success] = 'Successfully signed up for EmployTown!'
        redirect_back_or_to home_url_for(user)
      else
        flash[:error] = "There was a problem signing you up. Try filling out the signup form again."
        redirect_to signup_path
      end
    else
      flash[:error] = @user.errors.full_messages
      redirect_to signup_path
    end
  end

  private

    def get_layout
      return 'admin' if current_user
      'application'
    end
end



