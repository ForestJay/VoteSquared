# Controller for watching politicians
class WatchesController < ApplicationController
  def create
    @politician = Politician.find(params[:politician_id])
    if ! user_signed_in?
      redirect_to user_omniauth_authorize_path(:facebook)
    elsif watch = already_watching?(@politician)
      watch.destroy
      flash[:notice] = "You are no longer watching #{@politician.full_name}."
    else
      @watch = @politician.watches.create()
      @watch.watcher_id = current_user.id
      flash[:notice] = "You are now watching #{@politician.full_name}!"
      @watch.save
    end
    
    if user_signed_in?
      redirect_to politician_path(@politician.id)
    end
  end

  def already_watching?(politician)
    politician.watches.each do |watch|
      if watch.watcher_id == current_user.id
        return watch
      end
    end
    return false
  end
  
  # Private members
  private

  def watches_params
    params.require(:watch).permit(:watcher_id, :watched_id)
  end
end