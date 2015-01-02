#\ -s puma

require './lib/chef_dashboard'

if ENV['RACK_ENV'] == 'test'
  require 'chef_zero/server'

  run Rack::URLMap.new(
    '/' => ChefZero::Server.new.send('app'),
    '/dash' => ChefDashboard::Web
  )
else
  run ChefDashboard::Web
end
