require './config/environment'
require 'sinatra/base'

class UtilitiesController < Sinatra::Base

  get "/api/v1/utilities" do
    begin
      utilities = UtilitiesService.fetch_utilities
      body JSON({"data" => utilities.map{|k| {"id": k.id, "utility_name": k.utility_name}}}, :encoder => :to_json, :content_type => :json)
      status 200
    rescue
      body JSON({"error" => "Something went wrong."})
    end
  end

  get "/api/v1/new_user" do
    if params[:email] && params[:utility]
      interval = UtilitiesService.create_form(params)
      body JSON({"data" => interval}, :encoder => :to_json, :content_type => :json )
    else
      body JSON({"error" => "Must send customer email and utility ID"}, :encoder => :to_json, :content_type => :json)
      status 404
    end
  end

  get "/api/v1/get_meters" do
    if params[:referral]
      meters = UtilitiesService.get_meters(params[:referral])
      meter_arr = meters.map{|meter| {meter_uid: meter}}
      body JSON({"data" => meter_arr}, :encoder => :to_json, :content_type => :json)
    else
      body JSON({"error" => "Must send customer email and utility ID"}, :encoder => :to_json, :content_type => :json)
      status 404
    end
  end

  get "/api/v1/bills" do
    if params[:meter_uid]
      bills = BillsFacade.check_the_bills(params)
      body JSON({"data" => bills}, :encoder => :to_json, :content_type => :json)
      status 200
    else
      body JSON({"error" => "Must send meter_uid"}, :encoder => :to_json, :content_type => :json)
      status 404
    end
  end
end
