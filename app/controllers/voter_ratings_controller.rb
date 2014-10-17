class VoterRatingsController < ApplicationController
  def create
    @politician = Politician.find(params[:politician_id])
    @voter_rating = @politician.voter_ratings.create(voter_rating_params)
    # There has to be a better way to get the data from params:
    @voter_rating.pros = voter_rating_params["pros"]
    @voter_rating.cons = voter_rating_params["cons"]
    @voter_rating.user_id = current_user.id
    @voter_rating.voter = voter_rating_params["voter"]
    @voter_rating.voted_for = voter_rating_params["voted_for"]
    @voter_rating.promised = voter_rating_params["promised"]
    @voter_rating.achieved = voter_rating_params["achieved"]
    @voter_rating.save
    redirect_to politician_path(@politician)
  end

  def destroy
    @politician = Politician.find(params[:politician_id])
    @voter_rating = @politician.voter_ratings.find(params[:id])
    @voter_rating.destroy
    redirect_to politician_path(@politician)
  end
  
  private

  def voter_rating_params
    params.require(:voter_rating).permit(:user_id, :rating, :pros, :cons, :voter, :voted_for, :promised, :achieved)
  end
end
