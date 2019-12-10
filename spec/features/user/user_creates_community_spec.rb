require 'support/features/create_community.rb'
require "rails_helper"

feature "user creates community" do
  scenario "successfully" do
    login_as create(:user)

    create_community

    expect(page).to have_css "h1", text: "w/rubyonrails"
    expect(page).to have_css "h3", text: "Ruby on Rails"
  end

  scenario "and is automatically subscribed to it" do
    login_as create(:user)

    create_community

    expect(page).to have_link text: 'Unsubscribe'
    expect(page).to have_css "p#subscribed_count", text: "1"
  end
end
