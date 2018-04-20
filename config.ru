# This file is used by Rack-based servers to start the application.

require_relative 'config/environment'

run Rails.application
require 'sidekiq/web'
require 'sidekiq-statistic'

use Rack::Session::Cookie, secret: '938d928h398hd298h9283h'
#Sidekiq::Web.instance_eval { @middleware.reverse! } # Last added, First Run
