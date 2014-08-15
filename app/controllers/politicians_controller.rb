class PoliticiansController < ApplicationController
  def new
  end

  def create
    @politician = Politician.new(politician_params)
    
     @politician.save
     redirect_to @politician
  end
  
  def show
    @politician = Politician.find(params[:id])
  end
  
  def index
    @politicians = Politician.all
  end
  
  # Private members
  private
  
  def politician_params
    params.require(:politician).permit(:first_name, :last_name, :country, :state, :current_office)
  end
end