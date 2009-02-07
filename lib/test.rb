require 'rubygems'
require 'activesupport'
require File.join(File.dirname(__FILE__), '..', 'lib', 'twitter')
#config = YAML::load(open(ENV['HOME'] + '/.twitter'))
config = YAML::load(open('tweet.yml'))
 
twitter = Twitter::Base.new(config['username'], config['password'])
 
puts 'SINCE'
twitter.replies(:since => Time.now - 5.day).each do |s|
  puts "- #{s.text}"
end
puts
puts
 
puts 'SINCE_ID'
twitter.replies(:since_id => 863081345).each do |s|
  puts "- #{s.text}"
end
puts
puts
 
puts 'PAGE'
twitter.replies(:page => 1).each do |s|
  puts "- #{s.text}"
end
puts
puts