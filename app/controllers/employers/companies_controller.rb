class Employers::CompaniesController < Employers::EmployersController
  before_filter :check_nil_company, :only => :edit
  before_filter :check_for_company, :only => :new
  before_filter :get_company, :except => [:new, :create]
  # before_filter :check_company_matches_current_users_company, :only => [:edit]
  
  # def index
  #  @companies = Company.all
  #
  #  respond_to do |format|
  #    format.html # index.html.erb
  #    format.xml  { render :xml => @companies }
  #  end
  # end

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
  end

  def create
    @company = Company.new(params[:company])

    if @company.save
      current_user.add_company(@company.id)
      flash[:success] = 'Company was successfully created.'
      redirect_to edit_employers_company_path
    else
      render :action => "new"
    end
  end

  def update
    if @company.update_attributes(params[:company])
      flash[:success] = "#{@company.name} was successfully updated."
      redirect_to edit_employers_company_path
    else
      render :edit
    end
  end

  def enable_media
    if @company.update_attributes(params[:social_flag] => true)
      puts 'true'
      redirect_to edit_employers_company_path
    else
      puts 'false'
      render :edit
    end
  end

  def disable_media
    if @company.update_attributes(params[:social_flag] => false)
      redirect_to edit_employers_company_path
    else
      render :edit
    end
  end
  
  protected

    def get_company
      @company = current_user.company
    end

    def check_for_company
      redirect_to edit_employers_company_path if current_user.belongs_to_company?
    end

    def check_nil_company
      unless current_user.belongs_to_company?
        flash[:error] = "You don't belong to a company. Please create one to continue."
        redirect_to new_employers_company_path
      end
    end
end
