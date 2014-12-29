class Vote
  include MongoMapper::Document
  
  belongs_to :voter_rating
  
  attr_accessible :useful

  key :useful, Boolean
  key :voter_rating_id, ObjectId
  key :user_id, ObjectId

end
