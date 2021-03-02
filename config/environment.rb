ENV['SINATRA_ENV'] ||= 'development'
require 'bundler/setup'
Bundler.require(:default, ENV['SINATRA_ENV'])
require "./app/controllers/api/v1/utilities_controller"
require_all "app"
