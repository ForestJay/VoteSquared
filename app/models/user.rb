class User
  include MongoMapper::Document
  
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable,
    :confirmable, :omniauthable, :omniauth_providers => [:facebook]
    
  attr_accessible :gplus, :name
  
  key :name, String
  key :gplus, String
  key :country, String
  key :state, String
  
  validates :name, presence: true,
                      length: { minimum: 2 }
  validates :gplus, :uniqueness => true, presence: true,
                      length: { minimum: 2 }
  validates :country, presence: true
  
  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.name = auth.info.name   # assuming the user model has a name
      user.image = auth.info.image # assuming the user model has an image
    end
  end
end
