require 'spec_helper'
require_relative '../../lib/chef_dashboard/nodes'

describe ChefDashboard::Nodes do
  subject { described_class.new 'http://127.0.0.1:4000', 'stickywicket', 'spec/fixtures/.chef/stickywicket.pem' }

  describe '#all' do
    it 'should return all nodes' do
      all_nodes = subject.all
      expect(all_nodes.length).to eq(3)
    end
  end

  describe '#running' do
    it 'should return a node running the specified app' do
      node_running_foo = subject.running(:foo_app)

      expect(node_running_foo.length).to eq(1)
    end
  end
end
