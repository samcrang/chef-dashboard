require 'sinatra/base'
require 'sinatra/json'
require 'ridley'
require 'faraday'

class ChefDashboard < Sinatra::Base
  set :views, Proc.new { File.join(root, "../views") }

  def apps
    {
      FooApp: {
        recipe: 'recipe\\[foo_app\\]',
        expected_version: '3.141',
        actual_version: 'foo/version'

      },
      BarApp: {
        recipe: 'recipe\\[bar_app\\]',
        expected_version: '3.141',
        actual_version: 'bar/version'
      }
    }
  end

  get '/servers' do
    ridley = Ridley.new(
      server_url: 'http://127.0.0.1:4000',
      client_name: 'stickywicket',
      client_key: 'spec/fixtures/.chef/stickywicket.pem'
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
