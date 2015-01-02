require 'spec_helper'

describe '/deployments/:app', type: :feature do
  it 'displays all nodes running foo_app' do
    visit '/deployments/foo_app'
    expect(page).to have_content 'foo'
    expect(page).to have_content '3.141592'
    page.assert_selector('tr', count: 1)
  end
end
