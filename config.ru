require 'chef_zero/server'
require 'sinatra/base'

class Foo < Sinatra::Base
  get '/version' do
    '3.14159'
  end
end

run Rack::URLMap.new(
  '/' => ChefZero::Server.new.send('app'),
  '/foo' => Foo.new
)
