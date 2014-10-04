class User
  include MongoMapper::Document
  plugin MongoMapper::Plugins::IdentityMap
   
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable,
    :confirmable, :omniauthable, :omniauth_providers => [:facebook]
    
  attr_accessible :email, :name, :encrypted_password, :confirmed_at
  
  key :name, String
  key :email, String
  key :password, String
  key :image, String
  key :encrypted_password, String
  key :confirmed_at, Time
  key :confirmation_sent_at, Date
  key :confirmation_token, String
  key :zip, String
  key :current_sign_in_at, Time
  key :last_sign_in_at, Time
  key :current_sign_in_ip, String
  key :last_sign_in_ip, String
  key :sign_in_count, Integer
  key :remember_created_at, Time
    
  validates :name, presence: true,
                      length: { minimum: 2 }
  validates :encrypted_password, :uniqueness => true, presence: true,
                      length: { minimum: 2 }
  validates :zip, presence: true
  
  def self.from_omniauth(auth)
    user = where(:email => auth.info.email).first
    if user.present?
      # Try deleting the user . . . maybe the date format it was created with was bad!
      #user.destroy
    else
      user = User.new
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.name = auth.info.name  
      user.image = auth.info.image 
      user.zip = auth.info.zip
      user.save!
    end
    return user
  end
end
