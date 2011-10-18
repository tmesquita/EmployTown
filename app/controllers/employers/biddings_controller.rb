class Employers::BiddingsController < Employers::EmployersController
  before_filter :require_company

  # GET /biddings
  # GET /biddings.xml
  def index
    @biddings = current_user.get_my_biddings
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
    @bidding = Bidding.new(params[:bidding])
    @bidding.seeker_id = params[:seeker_id]
    @bidding.employer_id = current_user.id
    @bidding.date = Time.now
    respond_to do |format|
      if @bidding.save
        format.html { redirect_to(employers_biddings_path, :notice => 'Bidding was successfully created.') }
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
      format.html { redirect_to(employers_biddings_path) }
      format.xml  { head :ok }
    end
  end
end

private

  def require_company
    if !current_user.belongs_to_company?
      redirect_to employers_companies_path      
    end 
  end