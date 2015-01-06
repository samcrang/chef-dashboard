require 'ridley'
require 'chef_dashboard/apps'

module ChefDashboard
  class Nodes
    def initialize(server_url, client_name, client_key_path)
      @ridley_connection_options = {
        server_url:  server_url,
        client_name: client_name,
        client_key: client_key_path
      }
    end

    def all
      ridley.search(:node, '*:*').map do |node|
        {
          name: node.name
        }
      end
    end

    def running(requested_app)
      app = apps.find(requested_app)

      return [] if app.nil?

      ridley.search(:node, "run_list:#{app.recipe}").map do |node|
        {
          name: node.name,
          app_name: app.class.name.split('::').last,
          expected_version: app.expected_version(node),
          actual_version: app.actual_version(node)
        }
      end
    end

    private

    def ridley
      @ridley ||= Ridley.new @ridley_connection_options
    end

    def apps
      @apps ||= ChefDashboard::Apps.new
    end
  end
end
