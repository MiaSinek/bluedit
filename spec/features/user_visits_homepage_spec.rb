require "rails_helper"

feature "User visits homepage" do
  # Smoke Test
  scenario "successfully" do
    visit root_path

    expect(page).to have_css 'h1', text: 'BLUEDIT'
  end
end