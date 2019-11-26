require 'support/features/sign_in.rb'
require "rails_helper"

feature "user subscribes to community" do
  scenario "successfully", js: true do
    community = create(:community)

    sign_in community.user.email, community.user.password

    click_on "Select a community"
    click_on community.name
    click_on "Subscribe"

    expect(page).to have_link text: 'Unsubscribe'
    expect(page).to have_css "p#subscribed_count", text: "1"
  end
end