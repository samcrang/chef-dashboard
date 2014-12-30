require 'spec_helper'

describe '/nodes', type: :feature do
  it 'displays all nodes' do
    visit '/nodes'
    expect(page).to have_content 'foo'
    expect(page).to have_content 'bar'
    expect(page).to have_content 'baz'
    page.assert_selector('tr', count: 3)
  end

  it 'displays all nodes' do
    visit '/nodes/running/foo_app'
    expect(page).to have_content 'foo'
    expect(page).to have_content '3.141592'
    page.assert_selector('tr', count: 1)
  end
end
