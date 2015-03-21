class VoterRatingsController < ApplicationController
  def create
    @politician = Politician.find(params[:politician_id])
    @voter_rating = @politician.voter_ratings.create(voter_rating_params)
    # There has to be a better way to get the data from params:
    @voter_rating.user_id = current_user.id
    file_common_fields
      
    current_user.add_points(5)
    flash[:notice] = "Thank you, you've earned 5 points!"
    
    @voter_rating.save
    @politician.watches.each do |watch|
      user = User.find(watch.watcher_id)
      puts user
      unless user.unsubscribe_all
         UserMailer.watched_politician_new_rating(@politician, @voter_rating, user).deliver
       end
    end
    redirect_to politician_path(@politician)
  end

  def destroy
    @politician = Politician.find(params[:politician_id])
    @voter_rating = @politician.voter_ratings.find(params[:id])
    @voter_rating.destroy
    current_user.add_points(-5)
    redirect_to politician_path(@politician)
  end
  
  def edit 
    @politician = Politician.find(params[:politician_id])
    @voter_rating = @politician.voter_ratings.find(params[:id])
  end
  
  def update
    @politician = Politician.find(params[:politician_id])
    @voter_rating = @politician.voter_ratings.find(params[:id])

    if @voter_rating.update_attributes(voter_rating_params)
      file_common_fields
      
      @voter_rating.save
      redirect_to @politician
    else
      render 'edit'
    end
  end
  
  # Private members
  private

  def file_common_fields
    @voter_rating.pros = voter_rating_params["pros"]
    @voter_rating.cons = voter_rating_params["cons"]
    @voter_rating.voter = voter_rating_params["voter"] 
    @voter_rating.voted_for = voter_rating_params["voted_for"]
    @voter_rating.promised = voter_rating_params["promised"]
    @voter_rating.achieved = voter_rating_params["achieved"]
  end
  
  def voter_rating_params
    params.require(:voter_rating).permit(:user_id, :rating, :pros, :cons, :voter, :voted_for, :promised, :achieved)
  end
end
