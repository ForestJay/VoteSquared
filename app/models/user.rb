class User
  include MongoMapper::Document
  plugin MongoMapper::Plugins::IdentityMap
  
  many :voter_ratings
   
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable,
    :confirmable, :omniauthable, :omniauth_providers => [:facebook]
    
  attr_accessible :email, :name, :encrypted_password, :confirmed_at, :points
   
  key :name, String
  key :email, String
  key :password, String
  key :image, String
  key :encrypted_password, String
  key :confirmed_at, Time
  key :confirmation_sent_at, Date
  key :confirmation_token, String
  key :current_sign_in_at, Time
  key :last_sign_in_at, Time
  key :current_sign_in_ip, String
  key :last_sign_in_ip, String
  key :sign_in_count, Integer
  key :remember_created_at, Time
  key :points, Integer
  key :sponsor, Boolean, :default => false
    
  validates :name, presence: true,
                      length: { minimum: 2 }
  validates :encrypted_password, presence: true,
                      length: { minimum: 2 }
  validates :email, :uniqueness => true, presence: true,
                      length: { minimum: 4 }
  validates :points, numericality: { only_integer: true }
  
  def self.from_omniauth(auth)
    user = where(:email => auth.info.email).first
    
    # user.destroy can be used here for testing new users.
    
    if user.present?
    else
      user = User.new
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.name = auth.info.name  
      user.image = auth.info.image 
      user.points = 0
      user.skip_confirmation!
      user.save!
    end
    return user
  end
  
  def add_points(new_points)
    if ! defined?(@points)
      @points = 0
    end
    @points += new_points
    self.save!
  end
  
  def display
    if ! defined?(@name)
      return " "
    elsif defined?(@points)
    else
      @points = 0
      self.save!
    end
    return_value = "<table><tr><td align=center><img src=#{self.image}></td><td><table><tr>"
    return_value += "<td><a href=/users/#{self.id}>#{@name}</a></tr></td><tr><td align=center>#{@points.to_s}"
    
    if @sponsor == true
      return_value += " <img src=/Halo.png width=12 height=12 alt='Sponsor Halo'>"
    end
    
    return_value += "</td></tr></table></td></table>"
    return return_value
  end
  
  def is_admin
    if self.id.to_s == ADMINS[self.id.to_s].to_s
      return true
    end
    return false
  end
end
