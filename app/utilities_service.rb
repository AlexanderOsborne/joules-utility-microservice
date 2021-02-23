class UtilitiesService < Sinatra::Base

  get "/https://utilityapi.com/api/v2/bills?meters=#{params[:meter_uiid]}" do
  
  end
end

