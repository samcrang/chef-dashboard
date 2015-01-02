#\ -s puma

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), 'lib'))
require 'chef_dashboard'

if ENV['RACK_ENV'] == 'test'
  require 'chef_zero/server'
  require './spec/helpers/dummy_app_configuration'

  run Rack::URLMap.new(
    '/' => ChefZero::Server.new.send('app'),
    '/dash' => ChefDashboard::Web
  )
else
  run ChefDashboard::Web
end
