class Seekers::BiddingsController < Seekers::SeekersController
  # GET /biddings
  # GET /biddings.xml
  def index
    @biddings = current_user.get_my_seeker_biddings
    @interested_biddings = current_user.get_my_interested_biddings
    @uninterested_biddings = current_user.get_my_uninterested_biddings
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @biddings }
    end
  end

  # GET /biddings/1
  # GET /biddings/1.xml
  def show
    @bidding = Bidding.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @bidding }
    end
  end

  # PUT /biddings/1
  # PUT /biddings/1.xml
  def update
    @bidding = Bidding.find(params[:id])

    respond_to do |format|
      if @bidding.update_attributes(params[:bidding])
        format.html { redirect_to(seekers_bidding_path(@bidding), :notice => 'Bidding was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @bidding.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /biddings/1
  # DELETE /biddings/1.xml
  def destroy
    @bidding = Bidding.find(params[:id])
    @bidding.destroy

    respond_to do |format|
      format.html { redirect_to(seekers_biddings_path) }
      format.xml  { head :ok }
    end
  end
  
  def interested
    @bidding = Bidding.find(params[:id])
    @bidding.interested = 1
    respond_to do |format|
      if @bidding.save
        format.html { redirect_to(seekers_bidding_path(@bidding), :notice => 'Bidding was successfully updated.') }
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
        format.html { redirect_to(seekers_bidding_path(@bidding), :notice => 'Bidding was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @bidding.errors, :status => :unprocessable_entity }
      end
    end
  end
end
