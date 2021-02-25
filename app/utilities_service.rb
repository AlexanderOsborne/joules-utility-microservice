require 'sinatra'
require 'faraday'

class UtilitiesService 
  def self.conn
    @@conn ||= Faraday.new(:url => 'https://utilityapi.com') do |req|
      req.headers['Authorization'] = "Bearer #{ENV['UTILITY_API_KEY']}"
    end
  end

  def self.get_new_user
    uid = post_form
    referral = post_auth(uid)
    meters = get_auth_and_meters(referral)
    post_activate_meters(meters)

    # meter uid's are returned-- pass back to backend to be saved
    meters
  end

  def self.activate_existing_user(meter_uids)
    post_activate_meters(meter_uids)
  end

  # Bills take time to generate after meter activation, so backend should call this method to poll meters (check status)
  def self.check_status(meter_uid)
    result = poll_meter(meter_uid)
    if result[:status] == "updated" && result[:bill_count] > 0
      # call get_bills (should return usage data)
      # calculate total kwh for first bill
      # tell backend to send "completed" mailer to user
    elsif result[:status] == "updated" && result[:bill_count] == 0
      # tell backend to send mailer to user to tell them their request is finished but they don't have any bills
    elsif result[:status] == "pending"
      # bill aren't ready yet
    elsif result[:status] == "errored"
      # something went wrong :/
    end
  end

  private
  
  def self.post_form
    response = conn.post do |req|
      req.url '/api/v2/forms'
    end

    json = parser(response)
    
    # json[:utility] needs to be passed to post_auth too
    json[:uid]
  end

  def self.post_auth(uid)
    response = conn.post do |req|
      req.url "/api/v2/forms/#{ uid }/test-submit"
      req.body = {"utility": "DEMO", "scenario": "residential"}.to_json
    end

    json = parser(response)
    json[:referral]
  end

  def self.get_auth_and_meters(ref)
    response = conn.get do |req|
      req.url "/api/v2/authorizations?referrals=#{ ref }&include=meters"
    end

    json = parser(response)
    json[:authorizations][0][:meters][:meters]
  end

  def self.post_activate_meters(meter_arr)
    response = conn.post do |req|
      req.url "/api/v2/meters/historical-collection"
      req.body = {"meters": meter_arr}.to_json 
    end

    # After activation, meters need to be polled to check status of bills
  end
  
  def self.poll_meter(meter_uid)
    response = conn.get do |req|
      req.url "/api/v2/meters/#{meter_uid}"
    end

    json = JSON.parse(response.body, symbolize_names: true)

    {
      status: json[:status], 
      bill_count: json[:bill_count]
    }
  end
  
  def self.get_bills(meter_uid)
    response = conn.get do |req|
      req.url "/api/v2/bills?meters=#{meter_uid}"
    end
    
    json = JSON.parse(response.body, symbolize_names: true)
  end

  def self.parser(response)
    JSON.parse(response.body, symbolize_names: true)
  end
end
