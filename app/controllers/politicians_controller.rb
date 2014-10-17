class PoliticiansController < ApplicationController
  def new
    @politician = Politician.new
  end

  def create
    @politician = Politician.new(politician_params)
    
    if @politician.save
      redirect_to @politician
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
   
    if @politician.update_attributes(politician_params)
      redirect_to @politician
    else
      render 'edit'
    end
  end
  
  def destroy
    @politician = Politician.find(params[:id])
    @politician.destroy
   
    redirect_to articles_path
  end
  
  # Private members
  private
  
  def politician_params
    params.require(:politician).permit(:first_name, :last_name, :country, :state, :current_office, :candidate_for, :last_edit_by, :voter_ratings)
  end
end