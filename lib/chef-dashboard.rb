require 'sinatra/base'
require 'sinatra/config_file'
require 'ridley'
require 'pry'

class ChefDashboard < Sinatra::Base
  register Sinatra::ConfigFile

  config_file '../config/config.yml'

  get '/' do
    ridley = Ridley.new(
      server_url: settings.chef_api_url,
      client_name: settings.chef_client_name,
      client_key: settings.chef_client_key_path
    )

    ridley.node.all.collect { |n| n.name }
  end
end

