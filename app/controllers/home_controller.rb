class HomeController < ApplicationController
  before_filter :require_login, :only => :secret
  
  #filter_access_to :all
  
  def index
    
  end
end