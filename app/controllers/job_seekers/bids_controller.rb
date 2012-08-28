class JobSeekers::BidsController < JobSeekers::JobSeekersController

  def show
    @bid = Bid.find(params[:id])

    render json: @bid
  end

  def accept
    @bid = Bid.find(params[:bid_id])
    if @bid.update_attributes(interested_flag: true)
      flash[:success] = 'The bid was updated successfully'
    else
      flash[:error] = @bid.errors.full_messages
    end
    redirect_to job_seekers_root_path
  end

  def decline
    @bid = Bid.find(params[:bid_id])
    if @bid.update_attributes(interested_flag: false)
      flash[:success] = 'The bid was updated successfully'
    else
      flash[:error] = 'There was a problem saving this bid'
    end
    redirect_to job_seekers_root_path
  end

end
