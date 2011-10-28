require File.dirname(__FILE__) + '/../app.rb'
require 'rspec'
require 'rack/test'
require 'nokogiri'

# set test environment
set :environment, :test
set :run, false
set :raise_errors, true
set :logging, false

set :cache_ttl, 0

RSpec.configure do |conf|
  conf.include Rack::Test::Methods
end