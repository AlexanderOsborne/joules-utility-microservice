require 'sinatra'
require 'faraday'

class UtilitiesService 

  def initialize
    @conn = Faraday.new(:url => 'https://utilityapi.com')
  end

  def new_user
    # call all 7 below it
  end

  def existing_user
    # only calls a few of them
  end
  
  def post_form(auth_param)
    response = @conn.post do |req|
      req.url '/api/v2/forms'
      req.headers['Authorization'] = "Bearer #{auth_param}"
    end
  end

  def post_auth(auth_param)
    response = @conn.post do |req|
      req.url "/api/v2/forms/#{ENV['UTILITY_UID']}/test-submit"
      req.headers['Authorization'] = "Bearer #{auth_param}"
      req.body = {"utility": "DEMO", "scenario": "residential"}.to_json
    end
  end

  def get_auth_and_meters(auth_param)
    response = @conn.get do |req|
      req.url "/api/v2/authorizations?referrals=#{ENV['REFERRAL']}&include=meters"
      req.headers['Authorization'] = "Bearer #{auth_param}"
    end
  end

  def post_activate_meters(auth_param)
    response = @conn.post do |req|
      req.url "/api/v2/meters/historical-collection"
      req.headers['Authorization'] = "Bearer #{auth_param}"
      req.body = {"meters": ["711267"]}.to_json 
      #Meter Uid's must be intered as an array- this is just a hardcode
    end
  end

  def get_poll_meter(auth_param)
    response = @conn.get do |req|
      req.url "/api/v2/meters/historical-collection/#{ENV['METER_UID']}"
      #Meter Uid's is not an array here - Meter UID is hardcoded in the url above
    end
    require 'pry'; binding.pry
  end

  def get_bills(auth_param)

  end
end


