require 'spec_helper'

describe '/apps', type: :feature do
  it 'displays all apps' do
    visit '/apps'

    page.within(:css, 'tbody') do
      page.within(:css, 'tr:first-child') do
        expect(page).to have_content 'FooApp'
        expect(page).to have_content 'foo_app'
      end

      expect(page).to have_selector('tr', count: 2)
    end
  end
end
