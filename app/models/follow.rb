class Follow
  include MongoMapper::Document

  belongs_to :user

  key :follower_id, ObjectId
end
