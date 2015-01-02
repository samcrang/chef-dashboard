require 'spec_helper'

describe '/deployments/:app', type: :feature do
  it 'displays all nodes running foo_app' do
    visit '/deployments/foo_app'

    page.within(:css, 'table') do
      page.within(:css, 'tr:first-child') do
        expect(page).to have_content 'foo'
        expect(page).to have_content 'FooApp'
        expect(page).to have_content '3.141'
        expect(page).to have_content '3.141592'
      end

      expect(page).to have_selector('tr', count: 1)
    end
  end
end
