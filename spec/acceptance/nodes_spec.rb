require 'spec_helper'

describe '/nodes', type: :feature do
  it 'displays all nodes' do
    visit '/nodes'

    page.within(:css, 'table') do
      page.within(:css, 'tr:first-child') do
        expect(page).to have_content 'bar'
      end

      expect(page).to have_selector('tr', count: 3)
    end
  end
end
