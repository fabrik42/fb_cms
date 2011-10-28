require 'spec_helper'

describe "fb_cms app" do
  include Rack::Test::Methods

  def app
    @app ||= Sinatra::Application
  end

  it "responds to /" do
    get '/'
    last_response.should be_ok
  end

  it "responds to /about" do
    get '/about'
    last_response.should be_ok
  end

  it "responds to /events" do
    get '/events'
    last_response.should be_ok
  end

  it "responds to /albums" do
    get '/albums'
    last_response.should be_ok
  end

  # it "returns an error page when a missing page is requested" do
  #   get "/this-page-does-not-exist"
  #   last_response.should_not be_ok
  #   last_response.body.should match( %r{sorry|not found|missing}i )
  # end

  it "has a google sitemap with at least one page in it" do
    get "/sitemap.xml"
    last_response.should be_ok
    last_response.body.should match( %r{urlset}i )
    r = Nokogiri::HTML(last_response.body)
    r.xpath("//urlset/url/loc/text()").to_s.should match( %r{^http} )
  end

end