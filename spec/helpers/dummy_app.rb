require 'sinatra/base'

class DummyApp < Sinatra::Base
  get '/dummy/foo/version' do
    '3.141592'
  end

  get '/dummy/bar/version' do
    '2.718281'
  end
end
