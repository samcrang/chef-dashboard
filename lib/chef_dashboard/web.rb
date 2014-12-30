require 'sinatra/base'
require 'sinatra/json'
require 'sinatra/config_file'

require_relative './nodes'

module ChefDashboard
  class Web < Sinatra::Base
    register Sinatra::ConfigFile

    config_file '../../config/config.yml'

    set :views, proc { File.join(root, '../../views') }

    get '/servers' do
      a = nodes.running(:foo_app) + nodes.running(:bar_app)
      haml :index, locals: { a: a }
    end

    private

    def nodes
      @nodes ||= ::ChefDashboard::Nodes.new(settings.chef_api_url, settings.chef_client_name, settings.chef_client_key_path)
    end
  end
end
