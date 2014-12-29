require 'sinatra/base'
require 'sinatra/json'
require 'ridley'
require 'faraday'
require 'byebug'

class App < Sinatra::Base
  def apps
    {
      :FooApp => {
        :recipe => 'recipe\\[foo_app\\]',
        :expected_version => '3.141',
        :actual_version => '/foo/version'

      },
      :BarApp => {
        :recipe => 'recipe\\[bar_app\\]',
        :expected_version => '3.141',
        :actual_version => '/bar/version'
      }
    }
  end

  get '/servers' do
    ridley = Ridley.new(
      :server_url => 'http://127.0.0.1:9292',
      :client_name => 'stickywicket',
      :client_key => 'test/fixtures/.chef/stickywicket.pem'
    )

    a = apps.reduce([]) { |memo, (k, v)|
      query = "run_list:#{v[:recipe]}"

       memo += ridley.search(:node, query).map { |n|
        {
          :name => n.name,
          :expected_version => v[:expected_version],
          :actual_version => Faraday.get("http://127.0.0.1:9292/#{v[:actual_version]}").body
        }
      }
    }
    haml :index, :locals => {:a => a}
  end

  run! if app_file == $0
end
