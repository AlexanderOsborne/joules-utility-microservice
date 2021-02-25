require 'sinatra'
require 'faraday'

class UtilitiesService 
  def self.conn
    @@conn ||= Faraday.new(:url => 'https://utilityapi.com') do |req|
      req.headers['Authorization'] = "Bearer #{ENV['UTILITY_API_KEY']}"
    end
  end

  def self.get_new_user
    post_form
    # this runs the method chain up to activate_meters
    # meter uid's are returned-- pass back to backend to be saved
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
    # utility needs to be passed to post_auth too
    post_auth(json[:uid])
  end

  def self.post_auth(uid)
    response = conn.post do |req|
      req.url "/api/v2/forms/#{ uid }/test-submit"
      req.body = {"utility": "DEMO", "scenario": "residential"}.to_json
    end

    json = parser(response)
    get_auth_and_meters(json[:referral])
  end

  def self.get_auth_and_meters(ref)
    response = conn.get do |req|
      req.url "/api/v2/authorizations?referrals=#{ ref }&include=meters"
    end

    json = parser(response)
    post_activate_meters(json[:authorizations][0][:meters][:meters])
  end

  def self.post_activate_meters(meter_arr)
    response = conn.post do |req|
      req.url "/api/v2/meters/historical-collection"
      req.body = {"meters": meter_arr}.to_json 
      # Hardcoded example:
      # req.body = {"meters": ["711267"]}.to_json 
    end

    json = parser(response)

    # After activation, meters need to be polled to check status of bills
    # return meter uids to get_new_user method so uids can be polled
    meter_arr
  end
  
  def self.poll_meter
    response = conn.get do |req|
      req.url "/api/v2/meters/#{ENV['METER_UID']}"
      #Meter Uid's is not an array here - Meter UID is hardcoded in the url above
    end
    
    json = JSON.parse(response.body, symbolize_names: true)
    
    {
      status: json[:meters][0][:status], 
      bill_count: json[:meters][0][:bill_count]
    }
  end
  
  def self.get_bills
    response = conn.get do |req|
      req.url "/api/v2/bills?meters=#{ENV['METER_UID']}"
    end
    
    json = JSON.parse(response.body, symbolize_names: true)
  end

  def self.parser(response)
    JSON.parse(response.body, symbolize_names: true)
  end
end
