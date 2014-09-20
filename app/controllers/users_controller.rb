class UsersController < ApplicationController
  def login
  end
  
  def new
    logger.debug "Processing the request..."
    user = User.find_by_gplus(params[:gplus])
    if user
      redirect_to root_url, notice: "You are already registered!"
    else
      @fullname = params[:fullname]
      @gplusId = params[:gplus]
      u = User.new(:name => params[:fullname], :gplus => params[:gplus])
      u.save
      redirect_to root_url, notice: "User with name #{@fullname} and Google+ ID #{@gplusId} has been successfully registered!"
    end
  end
end
