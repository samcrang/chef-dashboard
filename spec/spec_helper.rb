require 'rspec'
require 'capybara/rspec'
require 'chef_zero/server'
require 'ridley'

require 'chef_dashboard'
require 'helpers/dummy_app_configuration'

Capybara.app = ChefDashboard::Web

RSpec.configure do |conf|
  conf.before(:all) do
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
  end
end
