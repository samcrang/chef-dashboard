$LOAD_PATH.unshift File.expand_path('../lib', __FILE__)

Gem::Specification.new do |s|
  s.name        = 'chef_dashboard'
  s.version     = '0.1.0'
  s.summary     = "Monitor deployment rollouts"
  s.description = "What version of what app is deployed where?"
  s.authors     = ["Sam Crang"]
  s.email       = 'sam.crang@gmail.com'
  s.files       = [Dir.glob("lib/**/*.rb")]
  s.homepage    = 'https://github.com/samcrang/chef-dashboard'

  s.add_dependency 'sinatra'
  s.add_dependency 'sinatra-contrib'
  s.add_dependency 'ridley'
  s.add_dependency 'haml'

  s.add_development_dependency 'chef-zero'
  s.add_development_dependency 'capybara'
  s.add_development_dependency 'rspec'
  s.add_development_dependency 'rake'
  s.add_development_dependency 'rubocop'
end

