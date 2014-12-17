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
    else
      render 'edit'
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