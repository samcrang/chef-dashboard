require 'spec_helper'

describe '/nodes', type: :feature do
  it 'displays all nodes' do
    visit '/nodes'
    expect(page).to have_content 'foo'
    expect(page).to have_content 'bar'
    expect(page).to have_content 'baz'
    page.assert_selector('tr', count: 3)
  end
end
