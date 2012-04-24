class Employers::UsersController < Employers::EmployersController

  before_filter :check_user_is_current_user

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
        flash[:success] = 'Information has been successfully updated.'
        format.html { redirect_to(edit_employers_user_path(@user)) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  protected

    def check_user_is_current_user
      if !User.exists?(params[:id]) or User.find(params[:id]) != current_user
        flash[:error] = 'You do not have permission to edit that user'
        redirect_to edit_employers_user_path(current_user)
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
