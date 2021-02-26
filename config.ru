require 'bundler'
require 'fast_jsonapi'
require 'sinatra/base'
require 'figaro'
require 'rubygems'

Bundler.require

$LOAD_PATH.unshift(File.expand_path("app", __dir__))
$db = []
require 'controllers/application_controller'
require 'controllers/utilities_controller'
require 'controllers/bills_controller'
require 'services/utilities_service'
require 'poros/bill'



run ApplicationController
use UtilitiesController
use BillsController
