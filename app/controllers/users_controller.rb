class UsersController < ApplicationController
  def login
  end
  
  def new(auth)
    user.email = auth.info.email
    user.password = Devise.friendly_token[0,20]
    user.name = auth.info.name   # assuming the user model has a name
    user.image = auth.info.image # assuming the user model has an image  
  end
  
  def destroy
    sign_out
  end
  
  def show
    @user = User.find(params[:id])
  end
end
