class Employers::BidsController < Employers::EmployersController
  before_filter :require_company

  def index
    @bids = current_user.bids.not_responded.paginate(:page => params[:page], :per_page => 2).order('created_at DESC')
    @interested_bids_count = current_user.bids.interested.count
    @not_interested_bids_count = current_user.bids.not_interested.count
  end

  def new
    @job_seeker = User.find(params[:job_seeker_id])
    @bid = Bid.new
  end

  def create
    @job_seeker = JobSeeker.find(params[:job_seeker_id])
    @bid = Bid.new(params[:bid])
    @bid.job_seeker = @job_seeker
    @bid.employer = current_user
    if @bid.save
      flash[:success] = 'Bid was sent sucessfully.'
      redirect_to employers_bids_path
    else
      render :action => "new"
    end
  end

  def destroy
    @bid = Bid.find(params[:id])
    @bid.destroy

    flash[:success] = 'You have successfully deleted the bid.'
    redirect_to request.referer.sub(/(\?page=)[0-9]+/, '?page=1')
  end

  def interested
    @bids = current_user.bids.interested.paginate(:page => params[:page], :per_page => 2).order('created_at DESC')
    @not_responded_bids_count = current_user.bids.not_responded.count
    @not_interested_bids_count = current_user.bids.not_interested.count
  end

  def not_interested
    @bids = current_user.bids.not_interested.paginate(:page => params[:page], :per_page => 2).order('created_at DESC')
    @interested_bids_count = current_user.bids.interested.count
    @not_responded_bids_count = current_user.bids.not_responded.count
  end
end


private

  def require_company
    if !current_user.belongs_to_company?
      flash[:error] = 'You must create a company before you can bid on potential employees'
      redirect_to new_employers_company_path
    end 
  end