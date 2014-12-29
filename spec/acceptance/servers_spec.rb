require 'spec_helper'

describe "/servers", :type => :feature do
  it "displays a list of servers" do
    visit '/servers'
    expect(page).to have_content 'foo'
    expect(page).to have_content 'bar'
  end
end
