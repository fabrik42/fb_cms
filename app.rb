require 'bundler'
Bundler.require
require 'active_support/time'
require 'active_support/inflector'

require './lib/assets'
require './lib/facebook'
require './lib/text'

Time.zone = "Berlin"
I18n.load_path << File.join(File.dirname(__FILE__), 'config', 'locales.yml')
I18n.locale = :de

Sinatra.register Assets
Sinatra.register Text

set :public,   File.dirname(__FILE__) + '/public'
set :views,    File.dirname(__FILE__) + '/views'
set :facebook, Hash[*ENV["DATA_FACEBOOK"].split(",")]
set :google,   Hash[*ENV["DATA_GOOGLE"].split(",")]
set :site_url, "http://www.example.org"

configure :development do
  set :redis, Redis.new
  set :cache_ttl, 0
end

configure :production do
  uri = URI.parse(ENV["REDISTOGO_URL"])
  set :redis, Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)
  set :cache_ttl, 30 * 60
end

get '/' do
  posts = Facebook::Post.all
  haml :index, :locals => { :posts => posts }
end

get '/about' do
  page = Facebook::Page.load
  haml :about, :locals => { :page => page }
end

get '/albums' do
  albums = Facebook::Album.all
  haml :albums, :locals => { :albums => albums }
end

get '/albums/:id/:name' do
  album = Facebook::Album.find(params[:id])
  haml :album, :locals => { :album => album }
end

get '/events' do
  events = Facebook::Event.all
  haml :events, :locals => { :events => events }
end

get '/events/:id/:name' do
  event = Facebook::Event.find(params[:id])
  haml :event, :locals => { :event => event }
end

get '/sitemap.xml' do
  haml :sitemap, :layout => false
end