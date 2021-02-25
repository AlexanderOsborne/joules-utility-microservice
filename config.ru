require 'bundler'
require 'fast_jsonapi'
require 'sinatra/base'

Bundler.require

$LOAD_PATH.unshift(File.expand_path("app", __dir__))
$db = []
require 'controllers/application_controller'
require 'controllers/utilities_controller'
require 'controllers/bills_controller'
require 'services/utilities_service'



# run ApplicationController
run UtilitiesController
use BillsController
