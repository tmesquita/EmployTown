class Employers::CompaniesController < Employers::EmployersController
  before_filter :employer_action_redirect, :only => [:index, :show]
  before_filter :check_company_matches_current_users_company, :only => [:edit]
  
  
  # GET /companies
  # GET /companies.xml
  def index
    @companies = Company.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @companies }
    end
  end

  # GET /companies/1
  # GET /companies/1.xml
  def show
    @company = Company.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @company }
    end
  end

  # GET /companies/new
  # GET /companies/new.xml
  def new
    @company = Company.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @company }
    end
  end

  # GET /companies/1/edit
  def edit
    @company = Company.find(params[:id])
    #@company = current_user.company
  end

  # POST /companies
  # POST /companies.xml
  def create
    @company = Company.new(params[:company])

    respond_to do |format|
      if @company.save
        current_user.add_company(@company.id)
        format.html { redirect_to(employers_company_path(@company), :notice => 'Company was successfully created.') }
        format.xml  { render :xml => @company, :status => :created, :location => @company }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @company.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /companies/1
  # PUT /companies/1.xml
  def update
    @company = Company.find(params[:id])
    #@company = current_user.company
    
    current_user.add_company(params[:id])
    respond_to do |format|
      if @company.update_attributes(params[:company])
        flash[:success] = "#{@company.name} was successfully updated."
        format.html { redirect_to(employers_company_path(@company)) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @company.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /companies/1
  # DELETE /companies/1.xml
  def destroy
    @company = Company.find(params[:id])
    @company.destroy

    respond_to do |format|
      format.html { redirect_to(employers_companies_path) }
      format.xml  { head :ok }
    end
  end

  def enable_facebook
    @company = Company.find(params[:id])
    #@company = current_user.company
    @company.facebook_enabled_flag = true
    respond_to do |format|
      if @company.save
        format.html { redirect_to employers_companies_path }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @company.errors, :status => :unprocessable_entity }
      end
    end
  end

  def disable_facebook
    @company = Company.find(params[:id])
    #@company = current_user.company
    @company.facebook_enabled_flag = false
    respond_to do |format|
      if @company.save
        format.html { redirect_to employers_companies_path }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @company.errors, :status => :unprocessable_entity }
      end
    end
  end

  def enable_twitter
    @company = Company.find(params[:id])
    #@company = current_user.company
    @company.twitter_enabled_flag = true
    respond_to do |format|
      if @company.save
        format.html { redirect_to employers_companies_path }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @company.errors, :status => :unprocessable_entity }
      end
    end
  end

  def disable_twitter
    @company = Company.find(params[:id])
    #@company = current_user.company
    @company.twitter_enabled_flag = false
    respond_to do |format|
      if @company.save
        format.html { redirect_to employers_companies_path }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @company.errors, :status => :unprocessable_entity }
      end
    end
  end

  def enable_blog
    @company = Company.find(params[:id])
    #@company = current_user.company
    @company.blog_enabled_flag = true
    respond_to do |format|
      if @company.save
        format.html { redirect_to employers_companies_path }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @company.errors, :status => :unprocessable_entity }
      end
    end
  end

  def disable_blog
    @company = Company.find(params[:id])
    #@company = current_user.company
    @company.blog_enabled_flag = false
    respond_to do |format|
      if @company.save
        format.html { redirect_to employers_companies_path }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @company.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  protected

    def check_company_matches_current_users_company
      
      if !Company.exists?(params[:id]) or Company.find(params[:id]) != current_user.company
        flash[:error] = "You do not have permission to edit that company"
        redirect_to edit_employers_company_path(current_user.company)#, :notice => 'You do not have permission to edit that company'
      #  flash[:error] = "Could not find a company with id of #{params[:id]}"
      #  redirect_to employers_root_path
      end
    end

    def employer_action_redirect
      if current_user.belongs_to_company?
        flash[:success] = flash[:success] unless flash[:success].nil?
        redirect_to edit_employers_company_path(current_user.company) #, :notice => "This is the company you currently work for."
      else
        redirect_to new_employers_company_path, :notice => "You don't belong to a company, please create a new one."
      end
    end
end
