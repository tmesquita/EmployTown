class Employers::BidsController < Employers::EmployersController
  before_filter :require_company
  helper_method :bid_filter

  def new
    @job_seeker = JobSeeker.find(params[:job_seeker_id])
    @bid = Bid.new
  end

  def show
    @bid = Bid.find(params[:id])
    render json: @bid
  end

  def create
    @job_seeker = JobSeeker.find(params[:job_seeker_id])
    @bid = Bid.new(params[:bid])
    @bid.job_seeker = @job_seeker
    @bid.employer = current_user
    if @bid.save
      flash[:success] = 'Bid was sent sucessfully.'
      redirect_to employers_root_path
    else
      flash.now[:error] = @bid.errors.full_messages
      render :new
    end
  end

  def destroy
    @bid = Bid.find(params[:id])
    @bid.destroy

    flash[:success] = 'You have successfully deleted the bid.'
    redirect_to employers_root_path
  end

end


private

  def require_company
    unless current_user.belongs_to_company?
      flash[:error] = 'You must create a company before you can bid on potential employees'
      redirect_to new_employers_company_path
    end 
  end