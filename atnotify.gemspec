Gem::Specification.new do |s|
  s.name         = "atnotify"
  s.version      = "0.0.4"
  s.date         = "2009-02-07"
  s.summary      = "Sends you an email when someone @replies you on twitter."
  s.email        = "hh@mailheist.com"
  s.homepage     = "http://r00tshell.com"
  s.description  = ""
  s.has_rdoc     = false
  s.require_path = "lib"
  s.bindir       = "bin"
  s.executables  = %w(atnotify)
  s.authors      = ["Justin Mazzi"]
  s.files        = ["lib/db.rb", "lib/email.rb", "bin/atnotify"]
  s.add_dependency  'dm-core'
  s.add_dependency  'dm-validations'
  s.add_dependency  'escape'
  s.add_dependency  'twitter'
end