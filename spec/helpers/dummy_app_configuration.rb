module ChefDashboard
  module Configuration
    module Apps
      class FooApp
        def identifier
          :foo_app
        end

        def recipe
          'recipe\\[foo_app\\]'
        end

        def expected_version
          '3.141'
        end

        def actual_version(node)
          '3.141592'
        end
      end

      class BarApp
        def identifier
          :bar_app
        end

        def recipe
          'recipe\\[bar_app\\]'
        end

        def expected_version
          '2.7182'
        end

        def actual_version(node)
          '2.7182'
        end
      end
    end
  end
end
