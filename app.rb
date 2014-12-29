require 'sinatra/base'
require 'sinatra/json'
require 'ridley'
require 'faraday'

class App < Sinatra::Base
  def apps
    [{
      :name => 'FooApp',
      :recipe => 'recipe\\[foo_app\\]',
      :version => '/version'
    },{
      :name => 'BarApp',
      :recipe => 'recipe\\[bar_app\\]',
      :version => '/version'
    }]
  end

  get '/servers' do
    ridley = Ridley.new(
      :server_url => 'http://127.0.0.1:9292',
      :client_name => 'stickywicket',
      :client_key => 'test/fixtures/.chef/stickywicket.pem'
    )

    query = apps.collect do |app|
      "run_list:#{app[:recipe]}"
    end.join(' or ')

    json ridley.search(:node, query).collect { |n|
      {
        :name => n.name,
        :run_list => ridley.node.find(n.name).run_list
      }
    }
  end

  run! if app_file == $0
end
