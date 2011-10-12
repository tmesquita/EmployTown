class Employers::SearchController < Employers::EmployersController
  def index
  	unless params[:search].blank?
  		puts params[:search]
  		@users = User.search(params[:search])
  		@users.delete_if{|user| user.seeking.eql? "employer"}
  		@tags = Tag.search(params[:search])
  	end
  end

end
