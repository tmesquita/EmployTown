class Employers::CompaniesController < Employers::EmployersController
  before_filter :employer_action_redirect, :only => [:index, :show]
  before_filter :check_company_matches_current_users_company, :only => [:edit]
  
  #def index
  #  @companies = Company.all
  #
  #  respond_to do |format|
  #    format.html # index.html.erb
  #    format.xml  { render :xml => @companies }
  #  end
  #end

  #def show
  #  @company = Company.find(params[:id])
  #
  #  respond_to do |format|
  #    format.html # show.html.erb
  #    format.xml  { render :xml => @company }
  #  end
  #end

  def new
    @company = Company.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @company }
    end
  end

  def edit
    @company = Company.find(params[:id])
  end

  def create
    @company = Company.new(params[:company])

    respond_to do |format|
      if @company.save
        current_user.add_company(@company.id)
        flash[:success] = 'Company was successfully created.'
        format.html { redirect_to(edit_employers_company_path(@company))}
        format.xml  { render :xml => @company, :status => :created, :location => @company }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @company.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @company = Company.find(params[:id])
    
    current_user.add_company(params[:id])
    respond_to do |format|
      if @company.update_attributes(params[:company])
        flash[:success] = "#{@company.name} was successfully updated."
        format.html { redirect_to(edit_employers_company_path(@company)) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @company.errors, :status => :unprocessable_entity }
      end
    end
  end

  #def destroy
  #  @company = Company.find(params[:id])
  #  @company.destroy
  #
  #  respond_to do |format|
  #    format.html { redirect_to(employers_companies_path) }
  #    format.xml  { head :ok }
  #  end
  #end

  def enable_facebook
    @company = Company.find(params[:id]) 
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
        redirect_to edit_employers_company_path(current_user.company)
      end
    end

    def employer_action_redirect
      if current_user.belongs_to_company?
        flash[:success] = flash[:success] unless flash[:success].nil?
        redirect_to edit_employers_company_path(current_user.company)
      else
        flash[:error] = "You don't belong to a company. Please create one to continue."
        redirect_to new_employers_company_path
      end
    end
end
