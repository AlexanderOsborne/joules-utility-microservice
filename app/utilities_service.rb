require 'sinatra'
require 'faraday'

class UtilitiesService 

  def self.conn
    @@conn ||= Faraday.new(:url => 'https://utilityapi.com') do |req|
      req.headers['Authorization'] = "Bearer #{ENV['UTILITY_API_KEY']}"
    end
  end

  def self.get_new_user
    require 'pry'; binding.pry
    # post_form
  end

  def self.existing_user
    # only calls a few of them
  end
  
  def self.post_form
    response = conn.post do |req|
      req.url '/api/v2/forms'
    end
  end

  def self.post_auth
    response = conn.post do |req|
      req.url "/api/v2/forms/#{ENV['UTILITY_UID']}/test-submit"
      req.body = {"utility": "DEMO", "scenario": "residential"}.to_json
    end
  end

  def self.get_auth_and_meters
    response = conn.get do |req|
      req.url "/api/v2/authorizations?referrals=#{ENV['REFERRAL']}&include=meters"
    end
  end

# works
  def self.post_activate_meters
    response = conn.post do |req|
      req.url "/api/v2/meters/historical-collection"
      req.body = {"meters": ["711267"]}.to_json 
      #Meter Uid's must be intered as an array- this is just a hardcode
    end
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

  # Bills take time to generate, so backend should call this method to check status of bills
  def self.check_status(meter_uid)
    result = poll_meter(meter_uid)
    if result[:status] == "updated" && result[:bill_count] > 0
      # calls get_bills (should return usage data)
      # calculates total kwh for first bill
      # tells backend to send "completed" mailer to user
    elsif result[:status] == "updated" && result[:bill_count] == 0
      # tells backend to send mailer to user to tell them their request is finished but they don't have any bills
    elsif result[:status] == "pending"
      # bills aren't ready yet
    elsif result[:status] == "errored"
      # something went wrong :/
    end
  end
end


