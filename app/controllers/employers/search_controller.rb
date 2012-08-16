class Employers::SearchController < Employers::EmployersController
  def index
  	unless params[:search].blank?
  		@users = User.search(params[:search], params[:users_page])
  		@users = @users.reject { |user| user.is_employer? }

  		@tags = Tag.search(params[:search], params[:tags_page])
  	end
  end

end
