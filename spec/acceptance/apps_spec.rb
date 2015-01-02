require 'spec_helper'

describe '/apps', type: :feature do
  it 'displays all apps' do
    visit '/apps'
    expect(page).to have_content 'foo_app'
    expect(page).to have_content 'bar_app'
  end
end
