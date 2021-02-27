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
     meters = data.first[:base][:meter_numbers]
     post_activate_meters(meters)

     meters
  end

  def self.activate_existing_user(meter_uids)
    post_activate_meters(meter_uids)
  end

  # Bills take time to generate after meter activation, so backend should call this method to poll meters (check status)
  def self.check_status(params)
    result = poll_meter(params[:meter_uid])
    if result[:status] == "updated" && result[:bill_count] > 0
      bills = get_bills(params[:meter_uid])
      bills[:bills].map{|bill| Bill.new(bill)}
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

  def self.conn
    @@conn ||= Faraday.new(:url => 'https://utilityapi.com') do |req|
      req.headers['Authorization'] = "Bearer #{ENV['UTILITY_API_KEY']}"
    end
  end
  
  def self.post_form(data)
    response = conn.post do |req|
      req.url '/api/v2/forms'
      req.body = {"customer_email": data[:customer_email], "utility": data[:utility]}.to_json
    end
    parser(response)
    # json[:utility] needs to be passed to post_auth too
    # {"uid" => json[:uid], "utility" => json[:utility]}
  end

  # def self.request_auth(data)
  #   response = conn.get do |req|
  #     req.url '/api/authorize/iandouglas_turing'
  #     req.body = {"customer_email": data[:customer_email], "utility": data[:utility]}.to_json
  #   end
  #   parser(response)
  # end

  def self.post_auth(uid, utility = "DEMO")
    response = conn.post do |req|
      req.url "/api/v2/forms/#{ uid }"
      req.body = {"utility": utility, "scenario": "residential"}.to_json
    end
    parser(response)
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
