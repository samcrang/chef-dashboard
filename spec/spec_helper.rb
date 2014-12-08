ENV['RACK_ENV'] = 'test'

require 'rspec'
require 'rack/test'
require 'chef-dashboard'
require 'chef_zero/server'

RSpec.configure do |conf|
  conf.include Rack::Test::Methods

  conf.before(:all) {
    @server = ChefZero::Server.new(port: 4000)
    @server.start_background
  }

  conf.after(:all) {
    @server.stop
  }
end
