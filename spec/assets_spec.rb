require 'spec_helper'

describe "fb_cms app" do
  include Rack::Test::Methods

  def app
    @app ||= Sinatra::Application
  end

  it "responds to /javascripts/all.js" do
    get '/javascripts/all.js'

    last_response.should be_ok
    last_response.body.should_not be_empty
  end
end