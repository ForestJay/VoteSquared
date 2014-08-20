class Politician
  include MongoMapper::Document
  
  key :first_name, String
  key :last_name, String
  key :country, String
  key :state, String
  key :current_office, String
  
  validates :first_name, presence: true,
                      length: { minimum: 2 }
  validates :last_name, presence: true,
                      length: { minimum: 2 }
  validates :country, presence: true
end
