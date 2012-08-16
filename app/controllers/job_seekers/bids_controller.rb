class JobSeekers::BidsController < JobSeekers::JobSeekersController

  def index
    @bids = current_user.bids.not_responded.paginate(:page => params[:page], :per_page => 2).order('created_at DESC')
    @interested_bids_count = current_user.bids.interested.count
    @not_interested_bids_count = current_user.bids.not_interested.count
  end
  
  def interested
    @bid = Bid.find(params[:id])
    @bid.interested_flag = true

    if @bid.save
      flash[:success] = 'You are now interested this bid.'
      redirect_to request.referer.sub(/(\?page=)[0-9]+/, '?page=1')
    else
      render :action => "edit"
    end
  end
  
  def not_interested
    @bid = Bid.find(params[:id])
    @bid.interested_flag = false

    if @bid.save
      flash[:success] = 'You are no longer interested in this bid.'
      redirect_to request.referer.sub(/(\?page=)[0-9]+/, '?page=1')
    else
      render :action => "edit"
    end
  end

  def interested_bids
    @bids = current_user.bids.interested.paginate(:page => params[:page], :per_page => 2).order('created_at DESC')
    @not_responded_bids_count = current_user.bids.not_responded.count
    @not_interested_bids_count = current_user.bids.not_interested.count
  end

  def uninterested_bids
    @bids = current_user.bids.not_interested.paginate(:page => params[:page], :per_page => 2).order('created_at DESC')
    @not_responded_bids_count = current_user.bids.not_responded.count
    @interested_bids_count = current_user.bids.interested.count
  end
end
