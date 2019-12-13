require 'support/features/sign_in.rb'
require "rails_helper"

feature "User visits communities page" do
  scenario "successfully" do
    2.times { create(:community) }

    visit communities_path

    expect(page).to have_text("Test community1 title")
    expect(page).to have_text("Test community2 title")
    expect(page).to have_text("Test community1 name")
    expect(page).to have_text("Test community2 name")
  end
end