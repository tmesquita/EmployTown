class Employers::SearchController < Employers::EmployersController
  def index
    unless params[:search].blank?
      @users = User.search(params[:search])
      @users = @users.reject { |user| user.is_employer? }

      tags = Tag.search(params[:search])
      @users = (@users + tags.map(&:user)).uniq
    end
  end

end
