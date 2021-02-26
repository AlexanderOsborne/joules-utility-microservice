require './app/services/utilities_service'

class UtilitiesController < ApplicationController
  set :root, File.expand_path("..", __dir__)

  get "/utilities" do
    utilities = UtilitiesService.fetch_utilities
    JSON({"data" => utilities.map{|k| {"id": k.id, "utility_name": k.utility_name}}}, :encoder => :to_json, :content_type => :json)
  end
end