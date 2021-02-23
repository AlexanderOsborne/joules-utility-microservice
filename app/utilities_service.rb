class UtilitiesService < Sinatra::Base

  def usage(meter_id)
    response = Faraday.new("https://utilityapi.com/api/v2/bills?meters=#{meter_id}") do |conn|
    conn.token_auth('authentication-token')
  end
end


