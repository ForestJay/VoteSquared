# Controller for following users
class FollowsController < ApplicationController
  def create
    @user = User.find(params[:user_id])
    if !user_signed_in?
      redirect_to user_omniauth_authorize_path(:facebook)
    # This is intentionally setting follow (ignore Rubocop == warnings)
    elsif follow = already_following?(@user)
      follow.destroy
      flash[:notice] = "You are no longer following #{@user.name}."
    else
      @follow = @user.follows.create
      @follow.follower_id = current_user.id
      flash[:notice] = "You are now watching #{@user.name}!"
      @follow.save
    end

    redirect_to user_path(@user.id) if user_signed_in?
  end

  def already_following?(user)
    user.follows.each do |follow|
      return follow if follow.follower_id == current_user.id
    end
    false
  end

  # Private members

  private

  def follows_params
    params.require(:follow).permit(:follower_id, :followed_id)
  end
end
