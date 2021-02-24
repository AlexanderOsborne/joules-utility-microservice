ENV['APP_ENV'] = 'test'

require 'test/unit'
require 'rack/test'
require './app/utilities_service'
# require './config/application.yml'
# 

class NewUserRequestTest < Test::Unit::TestCase
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  def test_it_gets_form
    utilities_service = UtilitiesService.new
    auth_param = ENV[UTILITY_API_KEY]
    data = utilities_service.post_form(auth_param)
    get '/api/v1/'
    assert last_response.ok?
    assert_equal 'Hello World', last_response.body
  end
end