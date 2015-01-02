require 'spec_helper'

describe '/apps', type: :feature do
  it 'displays all apps' do
    visit '/apps'

    page.within(:css, 'table') do
      page.within(:css, 'tr:first-child') do
        expect(page).to have_content 'FooApp'
        expect(page).to have_content 'foo_app'
        expect(page).to have_content '3.141'
      end

      expect(page).to have_selector('tr', count: 2)
    end
  end
end
