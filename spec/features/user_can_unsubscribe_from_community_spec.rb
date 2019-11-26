require 'support/features/sign_in.rb'
require "rails_helper"

feature "user unsubscribes from community" do
  scenario "successfully", js: true do
    subscription = create(:subscription)

    sign_in subscription.community.user.email, subscription.community.user.password

    visit community_path(subscription.community.id)
    click_on "Unsubscribe"

    expect(page).to have_link text: 'Subscribe'
    expect(page).to have_css "p#subscribed_count", text: "0"
  end
end