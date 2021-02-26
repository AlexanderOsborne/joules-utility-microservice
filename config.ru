require "./app"
require 'rubygems'
require 'sinatra'
require 'bundler'
require 'fast_jsonapi'
require 'figaro'

Bundler.require

$LOAD_PATH.unshift(File.expand_path("app", __dir__))
$db = []
require 'controllers/application_controller'
require 'controllers/utilities_controller'
require 'controllers/bills_controller'
require 'services/utilities_service'
require 'poros/bill'



run App
use ApplicationController
use UtilitiesController
use BillsController
