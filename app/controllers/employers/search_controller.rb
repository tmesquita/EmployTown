class Employers::SearchController < Employers::EmployersController
  def index
    unless params[:search].blank?
      tags = Tag.search(params[:search]).includes { user }
      @users = JobSeeker.search(params[:search]).includes{ bids }.includes{ role }
      @users = (@users + tags.map(&:user)).uniq
      @users = @users.reject { |user| user.is_employer? }
      @users = @users.reject { |user| user.has_bid_from_employer? current_user } if params[:exclude]

      @users = UserDecorator.decorate(@users)
    end
  end

end
