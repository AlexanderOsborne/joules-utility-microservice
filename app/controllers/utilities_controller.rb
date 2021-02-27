require './config/environment'
require 'sinatra/base'

class UtilitiesController < Sinatra::Base

  get "/utilities" do
    utilities = UtilitiesService.fetch_utilities
    body JSON({"data" => utilities.map{|k| {"id": k.id, "utility_name": k.utility_name}}}, :encoder => :to_json, :content_type => :json)
    status 200
  end

  get "/bills" do
    if params[:meter_uid]
      result = UtilitiesService.check_status(params)
      body JSON({"data" => result.map{|bill| {"start_date": bill.start_date, "end_date": bill.end_date, "kwh": bill.kwh, "meter_uid": bill.meter_uid, "user_uid": bill.user_uid}}}, :encoder => :to_json, :content_type => :json)
      status 200
    else
      body JSON({"data" => "Must send meter_uid"}, :encoder => :to_json, :content_type => :json)
      status 404 
    end
  end

  get "/new_user" do
    if params[:email] && params[:utility]
      interval = UtilitiesService.create_form(params[:email], params[:utility])
    else
      body JSON({"data" => "Must send customer email and utility ID"}, :encoder => :to_json, :content_type => :json)
      status 404 
    end
  end

  get "/get_meters" do
    if params[:referral]
      meters = UtilitiesService.get_meters(params[:referral])
      body JSON({"data" => meters}, :encoder => :to_json, :content_type => :json)
    else
      body JSON({"data" => "Must send customer email and utility ID"}, :encoder => :to_json, :content_type => :json)
      status 404 
    end
  end

end
