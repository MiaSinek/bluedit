require 'support/features/sign_in.rb'
require "rails_helper"

feature "User deletes authored community" do
  scenario "successfully" do
    community = create(:community)
    login_as community.user

    visit communities_path

    find(:css,"[href='#{community_path(community)}'][data-method='delete']").click

    expect(page).to have_text("Community was successfully destroyed.")
    expect(page).not_to have_text(community.name)
  end
end