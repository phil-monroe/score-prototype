class SiteController < ApplicationController
  
  def new
    
  end
  
  def create
    type = params[:user_type]
    user_name = params[:name]
    
    user = type.constantize.find_or_create_by_name(user_name)
    redirect_to user
  end
  
end