class Employers::SearchController < Employers::EmployersController
  def index
  	puts("here")
  	unless params[:search].blank?
  		puts params[:search]
  		@users = User.search(params[:search])
  	end
  end

end
