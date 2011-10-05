class Seekers::UsersController < Seekers::SeekersController
  def edit
    @user = User.find(params[:id])
  end
  
  def show
    @user = User.find(params[:id])
  end
end
