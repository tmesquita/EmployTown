class JobSeekers::CompaniesController < JobSeekers::JobSeekersController
  def show
    @company = CompanyDecorator.find(params[:id])
  end
end