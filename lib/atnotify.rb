require 'rubygems'  
require 'yaml'  
require 'twitter'
require 'lib/post'
#/usr/sbin/sendmail -i -t
def perform_delivery_sendmail(mail)
  sendmail_args = sendmail_settings[:arguments]
  sendmail_args += " -f \"#{mail['return-path']}\"" if mail['return-path']
  IO.popen("#{sendmail_settings[:location]} #{sendmail_args}","w+") do |sm|
    sm.print(mail.encoded.gsub(/\r/, ''))
    sm.flush
  end
end
send_email("hh@mailheist.com", "ME", "hh@mailheist.com", "Justin", "test", "message")

exit
config = YAML::load(File.open('tweet.yml'))
twit = Twitter::Base.new(config['username'], config['password'])
post = Post.first(:order => [:last_post_id.desc])

if post
  conditions = {:since => post.last_post_id}
else
  conditions = {}
end

twit.replies(conditions).each do |s|
  puts s.text
  Post.create(:username => s.user.screen_name, :name => s.user.name, :body => s.text, :last_post_id => s.id)
end
