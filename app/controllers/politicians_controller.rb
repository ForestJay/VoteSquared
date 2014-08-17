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