$:.unshift(File.dirname(__FILE__))
require 'rubygems'
require 'yaml'
require 'twitter'
require 'db'
require 'email'
require 'escape'

conf_file = "#{ENV['HOME']}/.atnotify.yml"

unless File.exists?(conf_file)
  puts "#{conf_file} doesn't exists. Please create it!"
  exit
end

config = YAML::load(File.open(conf_file))
twit = Twitter::Base.new(config['username'], config['password'], :api_host => 'identi.ca/api')
post = Post.first(:order => [:last_post_id.desc])
pust twit.rate_limit_status rescue

if post
  conditions = {:since => post.last_post_id}
else
  conditions = {}
end
body = ""
twit.replies(conditions).each do |s|
  Post.create(:username => s.user.screen_name, :name => s.user.name, :body => s.text, :last_post_id => s.id)
  body << "#{s.user.name} said: #{s.text} At #{Time.parse(s.created_at).strftime("%I:%M %p %b %d")}\n"
end
puts body
#send_mail(config['email'], body)
