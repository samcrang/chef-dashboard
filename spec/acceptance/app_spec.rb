require 'spec_helper.rb'

describe 'Dashboard' do
  def app
    ChefDashboard
  end

  before(:all) do
    Ridley.open(
      server_url: 'http://127.0.0.1:4000',
      client_name: 'admin',
      client_key: 'spec/fixtures/admin.pem'
    ) do |r|
      r.node.all.each do |n|
        r.node.delete(n)
      end

      %w(foo bar).each do |n|
        r.node.create(name: n)
      end
    end
  end

  it 'should return a list of nodes' do
    get '/'

    expect(last_response).to be_ok
    expect(last_response.body).to include('foo')
    expect(last_response.body).to include('bar')
  end
end
