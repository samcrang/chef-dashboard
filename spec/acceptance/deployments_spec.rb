require 'spec_helper'

describe '/deployments/:app', type: :feature do
  it 'displays all nodes and all the apps they run' do
    visit '/deployments'

    page.within(:css, 'tbody') do
      expect(page).to have_selector('tr.success', count: 1)
      expect(page).to have_selector('tr.danger', count: 1)
    end
  end
end

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

  it 'should return 404 if no app found' do
    visit '/deployments/unknown_app'

    expect(page.status_code).to equal 404
  end
end
