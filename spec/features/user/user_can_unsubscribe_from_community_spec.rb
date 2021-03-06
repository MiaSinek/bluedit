require "rails_helper"

feature "user unsubscribes from community" do
  scenario "successfully", js: true do
    community = create(:community)
    user = create(:user)
    subscription = create(:subscription, community: community, user: user)

    login_as user

    visit community_path(community)
    click_on "Unsubscribe"

    expect(page).to have_link text: 'Subscribe'
    expect(page).to have_css "p#subscribed_count", text: "0"
    expect(page).to have_text "You have successfully unsubscribed from #{community.name}"
  end
end