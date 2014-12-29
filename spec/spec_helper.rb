require 'rspec'
require 'capybara/rspec'
require 'chef_zero/server'
require 'ridley'
require 'rack'
require 'webmock/rspec'

require_relative '../lib/chef_dashboard'
require_relative 'helpers/dummy_app.rb'

Capybara.app = ChefDashboard

RSpec.configure do |conf|
  conf.before(:all) do
    WebMock.allow_net_connect!
    stub_request(:get, /http:\/\/127\.0\.0\.1\/dummy\/*/).to_rack(DummyApp)

    @server = ChefZero::Server.new(port: 4000)
    @server.start_background

    Ridley.open(server_url: 'http://127.0.0.1:4000', client_name: 'stickywicket', client_key: 'spec/fixtures/.chef/stickywicket.pem') do |ridley|
      %w(foo bar baz).each do |node|
        ridley.node.from_file("spec/fixtures/nodes/#{node}.json").save
      end
    end
  end

  conf.after(:all) do
    @server.stop
    WebMock.reset!
  end
end
