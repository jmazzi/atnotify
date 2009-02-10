require 'dm-core'
require 'dm-validations'

# Config
db = "#{ENV['HOME']}/.atnotify.db"
#DataMapper::Logger.new('db.log', :debug)
DataMapper.setup(:default, "sqlite3:///#{db}")

# Post
class Post
  include DataMapper::Resource
  property :id, Integer, :serial => true
  property :username, String, :index => true
  property :name, String
  property :body, String, :length => 140
  property :last_post_id, String, :index => true
  
  validates_is_unique :last_post_id
  
end

# Create the db if it doesn't exist
unless File.exists?(db)
  Post.auto_migrate!
end