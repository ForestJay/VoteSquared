class PoliticiansController < ApplicationController
  def new
    @politician = Politician.new
  end

  def create
    @politician = Politician.new(politician_params)

    if @politician.save
      redirect_to @politician
      flash[:notice] = "Thank you, you've earned 10 points!"
      current_user.add_points(10)
    else
      render 'new'
    end
  end

  def edit
    @politician = Politician.find(params[:id])
  end

  def show
    @politician = Politician.find(params[:id])
  end

  def index
    @politicians = Politician.all
  end

  def update
    @politician = Politician.find(params[:id])

    if @politician.last_edit_user_id != current_user.id
      flash[:notice] = "Thank you, you've earned 1 point!"
      current_user.add_points(1)
    end

    if @politician.update_attributes(politician_params)
      redirect_to @politician
      recipients = []
      @politician.watches.each do |watch|
        send_mail(watch.watcher_id)
        recipients += [watch.watcher_id]
      end
      current_user.follows.each do |follow|
        send_mail(follow.follower_id) unless recipients.include?(follow.follower_id)
      end
    else
      render 'edit'
    end
  end

  def send_mail(user_id)
    user = User.find(user_id)
    unless user.unsubscribe_all
      UserMailer.watched_politician_update(@politician, user, current_user).deliver
    end
  end

  def destroy
    @politician = Politician.find(params[:id])
    @politician.destroy
    if @politician.last_edit_user_id == current_user.id
      flash[:notice] = "You've lost 10 points!"
      current_user.add_points(-10)
    end

    redirect_to politicians_path
  end

  # Private members

  private

  def politician_params
    params.require(:politician).permit(:first_name, :last_name, :country, :state, :current_office, :candidate_for, :last_edit_user_id, :voter_ratings, :city, :county, :wikipedia_link, :campaign_link, :open_secrets_link, :official_link, :facebook, :google, :twitter)
  end
end
