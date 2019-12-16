require "rails_helper"

feature "user unsubscribes from community" do
  scenario "(s) he authored (and thus auto-subsscribed to), successfully", js: true do
    community = create(:community)

    login_as community.user

    visit community_path(community)
    click_on "Unsubscribe"

    expect(page).to have_link text: 'Subscribe'
    expect(page).to have_css "p#subscribed_count", text: "0"
    expect(page).to have_text "You have successfully unsubscribed from #{community.name}"
  end

  scenario "successfully, and only the auto-subscription of the community author remains", js: true do
    subscription = create(:subscription)
    community = subscription.community

    login_as subscription.user

    visit community_path(community)
    click_on "Unsubscribe"

    expect(page).to have_link text: 'Subscribe'
    expect(page).to have_css "p#subscribed_count", text: "1"
    expect(page).to have_text "You have successfully unsubscribed from #{community.name}"
  end

end