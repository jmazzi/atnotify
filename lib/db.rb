require 'dm-core'
require 'dm-validations'

# Config
db = "#{ENV['HOME']}/.atnotify.db"
DataMapper::Logger.new('db.log', :debug)
DataMapper.setup(:default, "sqlite3:///#{Dir.pwd}/test.db")

# Post
class Post
  include DataMapper::Resource
  property :id, Integer, :serial => true
  property :username, String, :index => true
  property :name, String
  property :body, String
  property :last_post_id, String, :index => true
  
  validates_is_unique :last_post_id
  
end