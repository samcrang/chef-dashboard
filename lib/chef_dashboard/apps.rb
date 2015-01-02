module ChefDashboard
  module Configuration
    module Apps
      class FooApp
        def identifier; :foo_app; end
        def recipe; 'recipe\\[foo_app\\]'; end
        def expected_version; '3.141'; end
        def actual_version; '3.141592'; end
      end

      class BarApp
        def identifier; :bar_app; end
        def recipe; 'recipe\\[bar_app\\]'; end
        def expected_version; '3.141'; end
        def actual_version; '3.141592'; end
      end
    end
  end
end

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
