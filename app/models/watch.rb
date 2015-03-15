class Watch
  include MongoMapper::Document
  
  belongs_to :politician

  key :watcher_id, ObjectId

end
