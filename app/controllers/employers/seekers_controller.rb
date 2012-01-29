class Employers::SeekersController < Employers::EmployersController
  def index
  	@seekers = User.find(:all)
  end

  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @seeker }
    end
  end

end
