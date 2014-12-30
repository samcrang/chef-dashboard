require 'sinatra/base'
require 'sinatra/json'
require "sinatra/config_file"
require 'ridley'
require 'faraday'

class ChefDashboard < Sinatra::Base
  register Sinatra::ConfigFile

  config_file '../config/config.yml'

  set :views, Proc.new { File.join(root, "../views") }

  def apps
    {
      FooApp: {
        recipe: 'recipe\\[foo_app\\]',
        expected_version: '3.141',
        actual_version: 'dummy/foo/version'

      },
      BarApp: {
        recipe: 'recipe\\[bar_app\\]',
        expected_version: '3.141',
        actual_version: 'dummy/bar/version'
      }
    }
  end

  get '/servers' do
    ridley = Ridley.new(
      server_url: settings.chef_api_url,
      client_name: settings.chef_client_name,
      client_key: settings.chef_client_key_path
    )

    a = apps.reduce([]) do |memo, (_, v)|
      query = "run_list:#{v[:recipe]}"

      memo + ridley.search(:node, query).map do |n|
        {
          name: n.name,
          expected_version: v[:expected_version],
          actual_version: Faraday.get("http://127.0.0.1/#{v[:actual_version]}").body
        }
      end
    end
    haml :index, locals: { a: a }
  end
end
