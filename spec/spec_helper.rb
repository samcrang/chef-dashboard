require 'rspec'
require 'capybara/rspec'
require 'chef_zero/server'
require 'ridley'

require_relative '../chef-dashboard'

Capybara.app = ChefDashboard

RSpec.configure do |conf|
  conf.before(:all) {
    @server = ChefZero::Server.new(port: 4000)
    @server.start_background

    Ridley.open(:server_url => 'http://127.0.0.1:4000', :client_name => 'stickywicket', :client_key => 'spec/fixtures/.chef/stickywicket.pem') do |ridley|
      %w(foo bar baz).each do |node|
        ridley.node.from_file("spec/fixtures/nodes/#{node}.json").save
      end
    end
  }

  conf.after(:all) {
    @server.stop
  }
end
