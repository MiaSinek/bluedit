require "rails_helper"

feature "user subscribes to community" do
  scenario "successfully", js: true do
    community = create(:community)
    user = create(:user)

    login_as user

    visit root_path

    click_on "Select a community"
    click_on community.name
    click_on "Subscribe"

    expect(page).to have_link text: 'Unsubscribe'
    expect(page).to have_css "p#subscribed_count", text: "1"
    expect(page).to have_text "You have successfully subscribed to #{community.name}"
  end
end