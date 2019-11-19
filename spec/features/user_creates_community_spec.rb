require "rails_helper"

feature "user creates community" do
  scenario "successfully" do
    user = User.create(username: "Someone", email: "someone@example.com", password: "password", password_confirmation: "password")

    visit root_path

    click_on "Login"

    fill_in "user[email]", with: "someone@example.com"
    fill_in "user[password]", with: "password"

    click_on "Log in"

    click_on "New Community"

    fill_in "community[name]", with: "rubyonrails"
    fill_in "community[title]", with: "Ruby on Rails"
    fill_in "community[sidebar]", with: "Ruby on Rails Palooza"
    fill_in "community[description]", with: "Best Ruby on Rails stuff"

    click_on "Create Community"

    expect(page).to have_css "h1", text: "w/rubyonrails"
    expect(page).to have_css "h3", text: "Ruby on Rails"
  end
end