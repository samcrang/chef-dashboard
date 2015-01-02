module ChefDashboard
  module Configuration
    module Apps
      class SimpleApp
        def identifier
          :simple_app
        end

        def recipe
          'recipe\\[simple_app\\]'
        end

        def expected_version
          '3.141'
        end

        def actual_version
          '3.141'
        end
      end
    end
  end
end
