ENV['APP_ENV'] = 'test'

require 'test/unit'
require 'rack/test'
require './app/utilities_service'

class NewUserRequestTest < Test::Unit::TestCase
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  def test_it_gets_form
    service = UtilitiesService.new
    auth_param = ENV['UTILITY_API_KEY']
    data = service.post_form(auth_param)
    # require 'pry'; binding.pry
    # assert last_response.ok?
    # assert_equal 'Hello World', last_response.body
  end

  def test_it_authorizes
    service = UtilitiesService.new
    auth_param = ENV['UTILITY_API_KEY']
    data = service.post_auth(auth_param)
    # assert last_response.ok?
    # assert_equal 'Hello World', last_response.body
  end

  def test_auth_and_meters
    service = UtilitiesService.new
    auth_param = ENV['UTILITY_API_KEY']
    data = service.get_auth_and_meters(auth_param)
    # require 'pry'; binding.pry
    # assert last_response.ok?
    # assert_equal 'Hello World', last_response.body
  end

  def test_activate_meters
    service = UtilitiesService.new
    auth_param = ENV['UTILITY_API_KEY']
    data = service.post_activate_meters(auth_param)
    require 'pry'; binding.pry
    # assert last_response.ok?
    # assert_equal 'Hello World', last_response.body
  end
end