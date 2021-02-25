ENV['APP_ENV'] = 'test'

require 'test/unit'
require 'rack/test'
require './app/utilities_service'

class NewUserRequestTest < Test::Unit::TestCase
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  def test_it_gets_new_user
    data = UtilitiesService.get_new_user
  end

  def test_it_gets_form
    data = UtilitiesService.post_form
    # assert last_response.ok?
    # assert_equal 'Hello World', last_response.body
  end

  def test_it_authorizes
    uid= "143397"
    data = UtilitiesService.post_auth(uid)
    # assert last_response.ok?
    # assert_equal 'Hello World', last_response.body
  end

  def test_auth_and_meters
    ref = "186474"
    data = UtilitiesService.get_auth_and_meters(ref)
    # require 'pry'; binding.pry
    # assert last_response.ok?
    # assert_equal 'Hello World', last_response.body
  end

  def test_activate_meters
    meter_arr = ["711267"]
    data = UtilitiesService.post_activate_meters(meter_arr)
    # assert last_response.ok?
    # assert_equal 'Hello World', last_response.body
  end
  
  def test_poll_meter
    meter_uid = "711267"
    data = UtilitiesService.poll_meter(meter_uid)

    # assert last_response.ok?
    # assert_equal 'Hello World', last_response.body
  end

  def test_new_user
    meter_uid = "711267"
    data = UtilitiesService.get_bills(meter_uid)
  end
end