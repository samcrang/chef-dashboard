module ChefDashboard
  class Apps
    def all
      apps.map do |app|
        {
          name: app.class.name.split('::').last,
          identifier: app.identifier
        }
      end
    end

    def find(app_identifier)
      apps.find do |app|
        app.identifier == app_identifier
      end
    end

    private

    def apps
      @apps ||=
        begin
          all_constants = ChefDashboard::Configuration::Apps.constants.collect do |k|
            ChefDashboard::Configuration::Apps.const_get(k)
          end

          all_classes = all_constants.select do |k|
            k.is_a?(Class)
          end

          all_classes.map(&:new)
        end
    end
  end
end
