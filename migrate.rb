require 'rubygems'
require 'dm-core'
require 'lib/models/user'
require 'lib/models/content'
require 'lib/models/setting'

if ARGV.first == "production"
  DataMapper.setup(:default, "sqlite3://#{Dir.pwd}/db/teenycms_prod.sqlite3")
  DataMapper.auto_migrate!
else
  DataMapper.setup(:default, "sqlite3://#{Dir.pwd}/db/teenycms.sqlite3")
  DataMapper.auto_migrate!
end