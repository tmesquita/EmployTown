class Employers::UsersController < Employers::EmployersController
  def edit
    @user = User.find_by_id(params[:id])
  end

  def show
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to(edit_employers_user_path(@user), :notice => 'User was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  #def update_attributes
  #  @user = User.find(params[:id])
  #  
  #  respond_to do |format|
  #    if @user.update_attributes(params[:user])
  #      format.html { redirect_to(edit_employers_user_path(@user), :notice => 'user was successfully updated.') }
  #      format.xml  { head :ok }
  #    else
  #      format.html { render :action => "edit" }
  #      format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
  #    end
  #  end
  #end

end
