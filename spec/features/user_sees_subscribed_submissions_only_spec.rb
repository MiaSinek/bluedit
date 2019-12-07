require "rails_helper"

feature "user goes to homepage" do
  scenario "doens't sees any submissions because (s)he is not subscribed to any community" do
    community_with_submissions_1 = create(:community, :with_submissions)
    login_as create(:user)

    expect(page).not_to have_css('div[id*="submission-"]')
  end

  scenario "sees only submissions belonging to communities (s)he is subscribed to" do
    #Create a community with submissions
    community_with_submissions_1 = create(:community, :with_submissions)
    #Create a subscription (it creates community with submissions and a user that is subscribed to it)
    subscription = create(:subscription)

    #Sign in with the user that has a subscription
    login_as subscription.user
    visit root_path

    #Expect subscribed user to see all five submissions belonging to the subscribed community
    expect(page).to have_css('div[id*="submission-"]', count: 5)

    expect(page).to have_css('div[id="submission-6"]')
    expect(page).to have_css('div[id="submission-10"]')
  end
end