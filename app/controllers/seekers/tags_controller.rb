class Seekers::TagsController < Seekers::SeekersController
  # GET /tags
  # GET /tags.xml
  def index
    @tags = Tag.find_all_by_user_id(current_user.id)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @tags }
    end
  end

  # GET /tags/1
  # GET /tags/1.xml
  def show
    @tag = Tag.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @tag }
    end
  end

  # GET /tags/new
  # GET /tags/new.xml
  def new
    @tags = Tag.find_all_by_user_id(current_user.id)
    @tag = Tag.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @tag }
    end
  end

  # GET /tags/1/edit
  def edit
    @tag = Tag.find(params[:id])
  end

  # POST /tags
  # POST /tags.xml
  def create
    @tag = Tag.new(params[:tag])
    @tag.user = current_user

    @tags = @tag.tag.split(",")
    
    saved = false
    
    for tag_name in @tags do
      tag = Tag.new(:user => current_user, :tag => tag_name)
      saved = true if tag.save   
    end
    
    respond_to do |format|
      if saved
        format.html { redirect_to new_seekers_tag_path, :notice => 'Tag(s) were successfully created'}
        #format.xml { render :xml => @tag, :status }
      else
        format.html { render :action => "new" }
      end
    end
    #respond_to do |format|
    #  if @tag.save
    #    format.html { redirect_to(seekers_tag_path(@tag), :notice => 'Tag was successfully created.') }
    #    format.xml  { render :xml => @tag, :status => :created, :location => @tag }
    #  else
    #    format.html { render :action => "new" }
    #    format.xml  { render :xml => @tag.errors, :status => :unprocessable_entity }
    #  end
    #end
  end

  # PUT /tags/1
  # PUT /tags/1.xml
  def update
    @tag = Tag.find(params[:id])

    respond_to do |format|
      if @tag.update_attributes(params[:tag])
        format.html { redirect_to(seekers_tag_path(@tag), :notice => 'Tag was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @tag.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /tags/1
  # DELETE /tags/1.xml
  def destroy
    @tag = Tag.find(params[:id])
    @tag.destroy

    respond_to do |format|
      format.html { redirect_to(new_seekers_tag_path) }
      format.xml  { head :ok }
    end
  end
end
