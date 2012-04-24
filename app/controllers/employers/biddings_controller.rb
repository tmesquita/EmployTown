class Employers::BiddingsController < Employers::EmployersController
  before_filter :require_company

  # GET /biddings
  # GET /biddings.xml
  def index
    #@biddings = current_user.get_my_biddings
    @bids = Bidding.where(:employer_id => current_user.id, :interested => nil).paginate(:page => params[:page], :per_page => 2).order('created_at DESC')
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

  # GET /biddings/new
  # GET /biddings/new.xml
  def new
    puts params[:seeker_id]
    @seeker = User.find(params[:seeker_id])
    @bidding = Bidding.new
    @seeker_id = params[:seeker_id]
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @bidding }
    end
  end

  # GET /biddings/1/edit
  def edit
    @bidding = Bidding.find(params[:id])
  end

  # POST /biddings
  # POST /biddings.xml
  def create
    @seeker = User.find(params[:seeker_id]) unless params[:seeker_id].nil?
    @bidding = Bidding.new(params[:bidding])
    @bidding.seeker_id = params[:seeker_id]
    @bidding.employer_id = current_user.id
    @bidding.date = Time.now
    respond_to do |format|
      if @bidding.save
        flash[:success] = 'Bid was sent sucessfully.'
        format.html { redirect_to(employers_biddings_path) }
        format.xml  { render :xml => @bidding, :status => :created, :location => @bidding }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @bidding.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /biddings/1
  # PUT /biddings/1.xml
  def update
    @bidding = Bidding.find(params[:id])

    respond_to do |format|
      if @bidding.update_attributes(params[:bidding])
        format.html { redirect_to(employers_bidding_path(@bidding), :notice => 'Bidding was successfully updated.') }
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
      flash[:success] = 'You have successfully deleted the bid.'
      format.html { redirect_to(request.referer.sub(/(\?page=)[0-9]+/, '?page=1')) }
      format.xml  { head :ok }
    end
  end

  def interested_bids
    @bids = Bidding.where(:employer_id => current_user.id, :interested => true).paginate(:page => params[:page], :per_page => 2).order('created_at DESC')
    #session[:return_to] = request.referer
  end

  def uninterested_bids
    @bids = Bidding.where(:employer_id => current_user.id, :interested => false).paginate(:page => params[:page], :per_page => 2).order('created_at DESC')
    #session[:return_to] = request.referer
  end
end


private

  def require_company
    if !current_user.belongs_to_company?
      redirect_to employers_companies_path      
    end 
  end