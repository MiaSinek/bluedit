 require 'support/features/sign_in.rb'
require "rails_helper"

feature "User updates authored community" do
  scenario "successfully" do
    community = create(:community)
    login_as community.user

    visit edit_community_path(community)

    fill_in 'community[title]', with: 'Edited Community Title'
    click_on 'Update Community'

    expect(page).to have_text("Edited Community Title")
  end

  scenario "unsuccessfully" do
    community = create(:community)
    login_as community.user

    visit edit_community_path(community)

    fill_in 'community[name]', with: ''
    click_on 'Update Community'

    expect(page).to have_text "1 error prohibited this community from being saved"
    expect(page).to have_text "Name can't be blank"
  end
end