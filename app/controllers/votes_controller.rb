# Controller for up and down voting a rating
class VotesController < ApplicationController
  def create
    @voter_rating = VoterRating.find(params[:voter_rating_id])
    if !user_signed_in?
      redirect_to user_omniauth_authorize_path(:facebook)
    elsif @voter_rating.user_id == current_user.id
      flash[:notice] = 'Silly human, you cannot give feedback on your own ratings!'
    elsif already_rated?(@voter_rating)
      flash[:notice] = "You seem to like the motto of `vote early, vote often!'  You cannot give feedback on a rating multiple times."
    else
      @vote = @voter_rating.votes.create
      @vote.user_id = current_user.id
      rating_user = User.find(@voter_rating.user_id)
      @vote.useful = useful?(params[:_method], @voter_rating, rating_user)
      unless rating_user.unsubscribe_all || rating_user.unsubscribe_useful
        UserMailer.useful(@voter_rating.politician, @voter_rating, rating_user, current_user, @vote.useful).deliver
      end

      flash[:notice] = "Thank you for your feedback on #{@voter_rating.user_name}'s rating!"
      @vote.save
    end

    redirect_to politician_path(@voter_rating.politician) if user_signed_in?
  end

  def useful?(method_param, _voter_rating, rating_user)
    if method_param == 'up_vote'
      rating_user.add_points(1)
      return true
    end
    false
  end

  def already_rated?(voter_rating)
    voter_rating.votes.each do |vote|
      return true if vote.user_id == current_user.id
    end
    false
  end

  # Private members

  private

  def votes_params
    params.require(:vote).permit(:voter_rating_id, :useful, :user_id)
  end
end
