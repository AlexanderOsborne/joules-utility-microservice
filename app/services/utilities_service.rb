class UtilitiesService 
  def self.fetch_utilities
    data = parser(conn.get("/api/v2/files/supported_utilities_json"))
    utilities = data.map {|utility| Utility.new(utility)}
  end

  def self.create_form(data)
    post_form(data)
  end

  def self.get_meters(referral)
     data = get_auth_and_meters(referral)
     meters = data.map{|meter| meter[:uid]}
     post_activate_meters(meters)
     meters
  end

  def self.activate_existing_user(meter_uids)
    post_activate_meters(meter_uids)
  end

  def self.poll_meter(meter_uid)
    response = conn.get do |req|
      req.url "/api/v2/meters/#{meter_uid}"
    end
    parser(response)
  end

  def self.get_bills(meter_uid)
    response = conn.get do |req|
      req.url "/api/v2/bills"
      req.params['meters'] = meter_uid
    end
    
    JSON.parse(response.body, symbolize_names: true)
  end

  private

  def self.conn
    @@conn ||= Faraday.new(:url => 'https://utilityapi.com') do |req|
      req.headers['Authorization'] = "Bearer #{ENV['UTILITY_API_KEY']}"
    end
  end

  def self.parser(response)
    JSON.parse(response.body, symbolize_names: true)
  end
  
  def self.post_form(data)
    response = conn.post do |req|
      req.url '/api/v2/forms'
      req.body = {"customer_email": data[:customer_email], "utility": data[:utility]}.to_json
    end
    parsed = parser(response)
  end
  
  def self.get_auth_and_meters(ref)
    response = conn.get do |req|
      req.url "/api/v2/authorizations?referrals=#{ref}&include=meters"
    end

    json = parser(response)
    json[:authorizations][0][:meters][:meters]
  end

  def self.post_activate_meters(meter_arr)
    response = conn.post do |req|
      req.url "/api/v2/meters/historical-collection"
      req.body = {"meters": meter_arr}.to_json 
    end
    parser(response)
  end

  # def self.request_auth(data)
  #   response = conn.get do |req|
  #     req.url '/api/authorize/iandouglas_turing'
  #     req.body = {"customer_email": data[:customer_email], "utility": data[:utility]}.to_json
  #   end
  #   parser(response)
  # end

  # def self.post_auth(uid, utility = "DEMO")
  #   response = conn.post do |req|
  #     req.url "/api/v2/forms/#{ uid }"
  #     req.body = {"utility": utility, "scenario": "residential"}.to_json
  #   end
  #   parser(response)
  # end
end
