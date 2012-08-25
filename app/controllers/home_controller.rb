class HomeController < ApplicationController
  before_filter :require_login, :only => :secret
  
  def index
    redirect_to home_url_for(current_user) if current_user
  end
end