class Employers::SearchController < Employers::EmployersController
  def search
  	unless params[:search].blank?
  		@users = User.search(params[:search])
  		puts here
  	end
  end

end
