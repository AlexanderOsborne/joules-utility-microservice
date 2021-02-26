# class BillsController < ApplicationController

#   get "/bills" do
#     if params[:meter_uid]
#       result = UtilitiesService.check_status(params)
#       JSON({"data" => result.map{|bill| {"start_date": bill.start_date, "end_date": bill.end_date, "kwh": bill.kwh, "meter_uid": bill.meter_uid, "user_uid": bill.user_uid}}}, :encoder => :to_json, :content_type => :json)
#     else
#       status 404 
#     end
#   end
# end