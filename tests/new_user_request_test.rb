ENV['APP_ENV'] = 'test'

require 'test/unit'
require 'rack/test'
require './app/utilities_service'

class NewUserRequestTest < Test::Unit::TestCase
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  # def test_new_user
  #   data = UtilitiesService.get_new_user
  # end

  def test_it_gets_form
    data = UtilitiesService.post_form
    # assert last_response.ok?
    # assert_equal 'Hello World', last_response.body
  end

  def test_it_authorizes
    data = UtilitiesService.post_auth
    # assert last_response.ok?
    # assert_equal 'Hello World', last_response.body
  end

  def test_auth_and_meters
    data = UtilitiesService.get_auth_and_meters
    # require 'pry'; binding.pry
    # assert last_response.ok?
    # assert_equal 'Hello World', last_response.body
  end

  def test_activate_meters
    data = UtilitiesService.post_activate_meters
    # assert last_response.ok?
    # assert_equal 'Hello World', last_response.body
  end
  
  def test_poll_meter
    data = UtilitiesService.poll_meter
    # require 'pry'; binding.pry
    # assert last_response.ok?
    # assert_equal 'Hello World', last_response.body
  end

  def test_new_user
    data = UtilitiesService.get_bills
  end
end