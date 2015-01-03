require 'sinatra/base'
require 'sinatra/json'
require 'sinatra/config_file'

require 'chef_dashboard/nodes'
require 'chef_dashboard/apps'

module ChefDashboard
  class Web < Sinatra::Base
    register Sinatra::ConfigFile

    set :views, proc { File.join(root, '../../views') }

    get '/' do
      haml :index
    end

    get '/apps' do
      a = apps.all
      haml :apps, locals: { apps: a }
    end

    get '/nodes' do
      n = nodes.all
      haml :nodes, locals: { nodes: n }
    end

    get '/deployments/:app' do |app|
      n = nodes.running(app.to_sym)

      if n.empty?
        status 404
      else
        haml :deployments, locals: { nodes: n }
      end
    end

    get '/deployments' do
      n = apps.all.reduce([]) do |memo, app|
        memo + nodes.running(app[:identifier])
      end

      haml :deployments, locals: { nodes: n }
    end

    private

    def nodes
      chef_api_url = ::ChefDashboard::Configuration::Settings.chef_api_url
      chef_client_name = ::ChefDashboard::Configuration::Settings.chef_client_name
      chef_client_key_path = ::ChefDashboard::Configuration::Settings.chef_client_key_path
      @nodes ||= ::ChefDashboard::Nodes.new(chef_api_url, chef_client_name, chef_client_key_path)
    end

    def apps
      @apps ||= ::ChefDashboard::Apps.new
    end
  end
end
