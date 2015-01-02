require 'spec_helper'

describe '/deployments/:app', type: :feature do
  it 'displays all nodes running foo_app' do
    visit '/deployments/foo_app'

    page.within(:css, 'tbody') do
      page.within(:css, 'tr:first-child') do
        expect(page).to have_content 'foo'
        expect(page).to have_content 'FooApp'
        expect(page).to have_content '3.141'
        expect(page).to have_content '3.141592'
      end

      expect(page).to have_selector('tr.danger', count: 1)
    end
  end

  it 'displays all nodes running bar_app' do
    visit '/deployments/bar_app'

    page.within(:css, 'tbody') do
      page.within(:css, 'tr:first-child') do
        expect(page).to have_content 'bar'
        expect(page).to have_content 'BarApp'
        expect(page).to have_content '2.7182'
      end

      expect(page).to have_selector('tr.success', count: 1)
    end
  end

end
