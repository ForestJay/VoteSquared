class VoterRating
  include MongoMapper::Document
  
  belongs_to :politician
  
  attr_accessible :voter, :rating
  
  key :rating, Integer
  key :pros, String
  key :cons, String
  key :voter, Boolean, :default => false
  key :voted_for, Boolean, :default => false
  key :promised, String
  key :achieved, String
  key :user_id, ObjectId
  
  # For backwards compatibility with records that have no last edit value this is being left out for now.
  #   We might not ever want to re-add it!
  # validates_associated :politician
  
  validates :rating, numericality: { only_integer: true, greater_than: 0, less_than: 6 }, 
    presence: true, length: { maximum: 1 }
                        
  def rating_html
    str = " "
    (1..5).each do |i|
      if @rating >= i
        str += "<img src=/Heart.png>"
      else
        str += "<img src=/EmptyHeart.png>"
      end
    end
    return str.html_safe
  end
  
  def user_display
    @user = User.find(@user_id)
    if defined?(@user_id)
      return @user.display
    else
      " "
    end
  end
  
  def politician_link
    @politician = Politician.find(@politician_id)
    return "<a href=/politicians/#{politician_id}>#{@politician.first_name} #{@politician.last_name}</a>"
  end
                        
end
