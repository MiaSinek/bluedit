require "rails_helper"

feature "user unsubscribes from community" do
  scenario "successfully", js: true do
    subscription = create(:subscription)

    login_as subscription.user

    visit community_path(subscription.community.id)
    click_on "Unsubscribe"

    expect(page).to have_link text: 'Subscribe'
    expect(page).to have_css "p#subscribed_count", text: "0"
    expect(page).to have_text "You have successfully unsubscribed from #{subscription.community.name}"
  end
end