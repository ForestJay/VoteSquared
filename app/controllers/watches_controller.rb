# Controller for watching politicians
class WatchesController < ApplicationController
  def create
    @politician = Politician.find(params[:politician_id])
    if !user_signed_in?
      redirect_to user_omniauth_authorize_path(:facebook)
    # This is intentionally setting watch (ignore Rubocop == warnings)
    elsif watch = already_watching?(@politician)
      watch.destroy
      flash[:notice] = "You are no longer watching #{@politician.full_name}."
    else
      @watch = @politician.watches.create
      @watch.watcher_id = current_user.id
      flash[:notice] = "You are now watching #{@politician.full_name}!"
      @watch.save
    end

    redirect_to politician_path(@politician.id) if user_signed_in?
  end

  def already_watching?(politician)
    politician.watches.each do |watch|
      return watch if watch.watcher_id == current_user.id
    end
    false
  end

  # Private members

  private

  def watches_params
    params.require(:watch).permit(:watcher_id, :watched_id)
  end
end
