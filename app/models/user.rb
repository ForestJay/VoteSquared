class User
  include MongoMapper::Document
  
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
end
