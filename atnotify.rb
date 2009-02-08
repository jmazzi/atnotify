$:.unshift(File.dirname(__FILE__) + '/lib')
require 'rubygems'
require 'yaml'
require 'twitter'
require 'db'
require 'email'

conf_file = "#{ENV['HOME']}/.atnotify.yml"

unless File.exists?(conf_file)
  puts "#{conf_file} doesn't exists. Please create it!"
  exit
end

config = YAML::load(File.open(conf_file))
twit = Twitter::Base.new(config['username'], config['password'])
post = Post.first(:order => [:last_post_id.desc])

if post
  conditions = {:since_id => post.last_post_id}
else
  conditions = {}
end
body = ""
twit.replies(conditions).each do |s|
  Post.create(:username => s.user.screen_name, :name => s.user.name, :body => s.text, :last_post_id => s.id)
  body << "#{s.user.name} said: #{s.text} At #{Time.parse(s.created_at).strftime("%I:%M %p %b %d")}\n"
end
send_mail(config['email'], body) unless body.empty?
