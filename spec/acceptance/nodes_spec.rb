require 'spec_helper'

describe '/nodes', type: :feature do
  it 'displays a list of servers' do
    visit '/nodes'
    expect(page).to have_content 'foo'
    expect(page).to have_content 'bar'
    expect(page).to have_content '3.141592'
  end
end
