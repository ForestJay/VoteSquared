class Politician
  include MongoMapper::Document
  
  many :voter_ratings
  
  # New fields need to be added to the controller, the form, and here.
  
  key :first_name, String
  key :last_name, String
  key :country, String
  key :state, String
  key :current_office, String
  key :candidate_for, String
  key :last_edit_user_id, ObjectId
  key :city, String
  key :county, String
  
  
  validates :first_name, presence: true,
                      length: { minimum: 2 }
  validates :last_name, presence: true,
                      length: { minimum: 2 }
  validates :country, presence: true

  validates :last_edit_user_id, presence: true,
                      length: { minimum: 2 }
  validates :city, :presence => true, :if => :town_or_city_office?
  validates :county, :presence => true, :if => :county_office?
  
  def town_or_city_office?
    if is_office?('city')
      return true
    elsif is_office?('town')
      return true
    end
    
    return false
  end 
  
  def county_office?
    if is_office?('county')
      return true
    end
    
    return false
  end   
  
  def is_office?(office)
    if @current_office.length == 0
    elsif OFFICES[COUNTRY][@current_office]['level'] == office
      return true
    end
    
    if @candidate_for.length == 0
    elsif OFFICES[COUNTRY][@candidate_for]['level'] == office
      return true
    end
    
    return false
  end        
                        
  def last_edit_user
    @user = User.find(@last_edit_user_id)
    if @user.nil?
      return " " 
    elsif defined?(@user)
      return @user.display
    else
      return " "
    end
    
  end
end
