class JobSeekers::TagsController < JobSeekers::JobSeekersController
  before_filter :check_tag_matches_owner, :only => :edit

  def new
    @tags = Tag.find_all_by_user_id(current_user.id)
    @tag = Tag.new
  end

  def edit
    @tag = Tag.find(params[:id])
  end

  def create
    @tag = Tag.new(params[:tag])
    @tag.user = current_user

    @tags = @tag.tag.split(",")
    
    saved = false
    
    for tag_name in @tags do
      tag = Tag.new(:user => current_user, :tag => tag_name.strip)
      saved = true if tag.save   
    end
    
    if saved
      flash[:success] = 'You have successfully added new tags.'
    else
      flash[:error] = 'There were problems saving your tag'
    end

    redirect_to new_job_seekers_tag_path
  end

  def update
    @tag = Tag.find(params[:id])

    if @tag.update_attributes(params[:tag])
      flash[:success] = 'You have successfully updated that tag'
      redirect_to new_job_seekers_tag_path and return
    else
      render :action => "edit"
    end
  end

  def destroy
    @tag = Tag.find(params[:id])
    @tag.destroy

    flash[:success] = 'You have successfully deleted that tag.'
    redirect_to new_job_seekers_tag_path
  end

  protected

    def check_tag_matches_owner
      if !Tag.exists?(params[:id]) or Tag.find(params[:id]).user != current_user
        flash[:error] = "You do not have permission to edit that tag"
        redirect_to new_job_seekers_tag_path
      end
    end
end
