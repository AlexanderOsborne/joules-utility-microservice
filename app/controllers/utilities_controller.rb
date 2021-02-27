require './config/environment'
require 'sinatra/base'

class UtilitiesController < Sinatra::Base

  get "/utilities" do
    utilities = UtilitiesService.fetch_utilities
    body JSON({"data" => utilities.map{|k| {"id": k.id, "utility_name": k.utility_name}}}, :encoder => :to_json, :content_type => :json)
    status 200
  end

  get "/new_user" do
    if params[:email] && params[:utility]
      interval = UtilitiesService.create_form(params)
      body JSON({"data" => interval}, :encoder => :to_json, :content_type => :json )
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

  get "/bills" do
    if params[:meter_uid]
      bills = BillsFacade.check_the_bills(params)
      body JSON({"data" => bills}, :encoder => :to_json, :content_type => :json)
      status 200
    else
      body JSON({"data" => "Must send meter_uid"}, :encoder => :to_json, :content_type => :json)
      status 404 
    end
  end



end
