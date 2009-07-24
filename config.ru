require 'rubygems'
require 'sinatra'
require 'lib/warden'
require 'app'

set :run, false

use Rack::Session::Cookie
use Warden::Manager do |manager|
  manager.default_strategies :password
  manager.failure_app = Sinatra::Application
end

run Sinatra::Application
