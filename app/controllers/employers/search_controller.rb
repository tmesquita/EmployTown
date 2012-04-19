class Employers::SearchController < Employers::EmployersController
  def index
  	unless params[:search].blank?
  		@users = User.search(params[:search])
  		@users.delete_if{|user| user.seeking.eql? "employer"}
  		@tags = Tag.search(params[:search]).remove_duplicates_by{|tag| tag.user_id}
  		#@tags = @tags
  	end
  end

end

class Array
  def remove_duplicates_by
    seen = Set.new
    select{ |x| seen.add? (yield(x))}
  end
end
