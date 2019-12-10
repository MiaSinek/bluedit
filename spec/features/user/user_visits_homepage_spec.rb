require 'support/features/sign_in.rb'
require "rails_helper"

feature "User visits homepage" do
  scenario "and signs up successfully" do
    visit root_path

    click_on "Sign up"

    fill_in "user[username]", with: "Jane Doe"
    fill_in "user[email]", with: "jane.doe@example.com"
    fill_in "user[password]", with: "sikrit"
    fill_in "user[password_confirmation]", with: "sikrit"

    page.find("form#new_user input[value='Sign up']").click

    expect(page).to have_text('You have signed up successfully.')
  end

  scenario "and logs in successfully" do
    user = create(:user)

    sign_in user.email, user.password

    expect(page).to have_text('Signed in successfully.')
  end

  scenario "and signs out successfully" do
    user = create(:user)

    sign_in user.email, user.password

    click_on "Sign out"

    expect(page).to have_text('Signed out successfully.')
  end
end