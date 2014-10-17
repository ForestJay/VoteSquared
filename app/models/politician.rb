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
  key :last_edit_by, String
  
  
  validates :first_name, presence: true,
                      length: { minimum: 2 }
  validates :last_name, presence: true,
                      length: { minimum: 2 }
  validates :country, presence: true

  validates :last_edit_by, presence: true,
                      length: { minimum: 2 }
end
