class Seekers::TagsController < Seekers::SeekersController
  before_filter :check_tag_matches_owner, :only => :edit

  #def index
  #  @tags = Tag.find_all_by_user_id(current_user.id)
  #
  #  respond_to do |format|
  #    format.html # index.html.erb
  #    format.xml  { render :xml => @tags }
  #  end
  #end

  #def show
  #  @tag = Tag.find(params[:id])
  #
  #  respond_to do |format|
  #    format.html # show.html.erb
  #    format.xml  { render :xml => @tag }
  #  end
  #end

  def new
    @tags = Tag.find_all_by_user_id(current_user.id)
    @tag = Tag.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @tag }
    end
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
    
    respond_to do |format|
      if saved
        flash[:success] = 'You have successfully added new tags.'
        format.html { redirect_to new_seekers_tag_path}
        #format.xml { render :xml => @tag, :status }
      else
        flash[:error] = 'There were problems saving your tag'
        format.html { redirect_to new_seekers_tag_path }
        #format.html { render :action => "new" }
      end
    end
  end

  def update
    @tag = Tag.find(params[:id])

    respond_to do |format|
      if @tag.update_attributes(params[:tag])
        flash[:success] = 'You have successfully updated that tag'
        format.html { redirect_to(new_seekers_tag_path) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @tag.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @tag = Tag.find(params[:id])
    @tag.destroy

    respond_to do |format|
      flash[:success] = 'You have successfully deleted that tag.'
      format.html { redirect_to(new_seekers_tag_path) }
      format.xml  { head :ok }
    end
  end

  protected

    def check_tag_matches_owner
      if !Tag.exists?(params[:id]) or Tag.find(params[:id]).user != current_user
        flash[:error] = "You do not have permission to edit that tag"
        redirect_to new_seekers_tag_path
      end
    end
end
