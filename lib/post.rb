require 'dm-core'
DataMapper::Logger.new('db.log', :debug)
DataMapper.setup(:default, "sqlite3:///#{Dir.pwd}/test.db")

class Post
  include DataMapper::Resource
  property :id, Integer, :serial => true
  property :username, String, :index => true
  property :name, String
  property :body, String
  property :last_post_id, String, :index => true
  
end