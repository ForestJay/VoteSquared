# Controller for users
class UsersController < ApplicationController
  def login
  end
  
  def new(auth)
    user.email = auth.info.email
    user.password = Devise.friendly_token[0,20]
    user.name = auth.info.name   # assuming the user model has a name
    user.image = auth.info.image # assuming the user model has an image  
    
    respond_to do |format|
      if @user.save
        # Tell the UserMailer to send a welcome email after save
        UserMailer.welcome_email(@user).deliver!

        format.html { redirect_to(@user, notice: 'User was successfully created.') }
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render action: 'new' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def destroy
    sign_out
  end
  
  def show
    @user = User.find(params[:id])
  end
  
  def edit 
    @user = User.find(params[:id])
  end
  
  def update_custom
    @user = User.find(params[:id])
      
    if current_user.is_admin
      @user.sponsor = is_true(params["users"]["sponsor"])
    end
    
    if current_user.is_admin or current_user.id == @user.id
      @user.unsubscribe_all = is_true(params["users"]["unsubscribe_all"])
    end
    
    if @user.save!
      redirect_to @user
    else
      render 'edit'
    end
  end
  
  def is_true(value)
    if value == 1.to_s 
      return true 
    else
      return false
    end
  end
end
