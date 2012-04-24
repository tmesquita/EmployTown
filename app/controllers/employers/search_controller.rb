class Employers::SearchController < Employers::EmployersController
  def index
  	unless params[:search].blank?
  		@users = User.search(params[:search], params[:users_page])
  		@users.delete_if{|user| user.seeking.eql? "employer"}
  		@tags = Tag.search(params[:search], params[:tags_page]) #.remove_duplicates_by{|tag| tag.user_id}
  	end
  end

end

class Array
  def remove_duplicates_by
    seen = Set.new
    select{ |x| seen.add?(yield(x))}
  end
end
