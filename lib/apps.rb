module ChefDashboard
  class Apps
    def find(app)
      {
        foo_app: {
          recipe: 'recipe\\[foo_app\\]',
          expected_version: '3.141',
          actual_version: '3.141592'

        },
        bar_app: {
          recipe: 'recipe\\[bar_app\\]',
          expected_version: '3.141',
          actual_version: '3.141592'
        }
      }[app]
    end
  end
end
