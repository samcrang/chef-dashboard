Dir['config/apps/*.rb'].each {|file| require "./#{file}" }

module ChefDashboard
  class Apps
    def all
      apps.map do |app|
        {
          identifier: app.identifier,
          recipe: app.recipe
        }
      end
    end

    def find(app_identifier)
      apps.find do |app|
        app.identifier == app_identifier
      end
    end

    def apps
      @apps ||= ::ChefDashboard::Configuration::Apps.constants.collect{|k| ::ChefDashboard::Configuration::Apps.const_get(k)}.select {|k| k.is_a?(Class)}.map {|k| k.new}
    end
  end
end
