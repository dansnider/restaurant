require 'bundler'
Bundler.require :default

require_relative 'controllers/application_controller'
require_relative 'controllers/foods_controller'
require_relative 'controllers/orders_controller'
require_relative 'controllers/parties_controller'

require './app'
map('/foods') { run FoodsController }
map('/orders') { run OrdersController }
map('/parties') { run PartiesController }
run Sinatra::Application