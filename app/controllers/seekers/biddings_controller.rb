class Seekers::BiddingsController < Seekers::SeekersController

  def index
    @bids = Bidding.where(:seeker_id => current_user.id, :interested => nil).paginate(:page => params[:page], :per_page => 2).order('created_at DESC')
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @bids }
    end
  end

  #def show
  #  @bidding = Bidding.find(params[:id])
  #
  #  respond_to do |format|
  #    format.html # show.html.erb
  #    format.xml  { render :xml => @bidding }
  #  end
  #end

  #def update
  #  @bidding = Bidding.find(params[:id])
  #
  #  respond_to do |format|
  #    if @bidding.update_attributes(params[:bidding])
  #      format.html { redirect_to(seekers_bidding_path(@bidding), :notice => 'Bidding was successfully updated.') }
  #      format.xml  { head :ok }
  #    else
  #      format.html { render :action => "edit" }
  #      format.xml  { render :xml => @bidding.errors, :status => :unprocessable_entity }
  #    end
  #  end
  #end

  #def destroy
  #  @bidding = Bidding.find(params[:id])
  #  @bidding.destroy
  #
  #  respond_to do |format|
  #    format.html { redirect_to(seekers_biddings_path) }
  #    format.xml  { head :ok }
  #  end
  #end
  
  def interested
    @bidding = Bidding.find(params[:id])
    @bidding.interested = 1
    respond_to do |format|
      if @bidding.save
        flash[:success] = 'You are now interested this bid.'
        format.html { redirect_to(request.referer.sub(/(\?page=)[0-9]+/, '?page=1')) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @bidding.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def not_interested
    @bidding = Bidding.find(params[:id])
    @bidding.interested = 0
    respond_to do |format|
      if @bidding.save
        flash[:success] = 'You are no longer interested in this bid.'
        format.html { redirect_to(request.referer.sub(/(\?page=)[0-9]+/, '?page=1')) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @bidding.errors, :status => :unprocessable_entity }
      end
    end
  end

  def interested_bids
    @bids = Bidding.where(:seeker_id => current_user.id, :interested => true).paginate(:page => params[:page], :per_page => 2).order('created_at DESC')
  end

  def uninterested_bids
    @bids = Bidding.where(:seeker_id => current_user.id, :interested => false).paginate(:page => params[:page], :per_page => 2).order('created_at DESC')
  end
end
