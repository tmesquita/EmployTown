class Employers::CompaniesController < Employers::EmployersController
  before_filter :check_nil_company, :only => :edit
  before_filter :check_for_company, :only => :new
  before_filter :get_company, :except => [:new, :create]

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
      flash[:error] = @company.errors.full_messages
      render :action => "new"
    end
  end

  def update
    if @company.update_attributes(params[:company])
      flash[:success] = "#{@company.name} was successfully updated."
      redirect_to edit_employers_company_path
    else
      flash.now[:error] = @company.errors.full_messages
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
